import SwiftUI
import AppKit

// MARK: - Debug Mode

let debugMode: Bool = {
    if CommandLine.arguments.contains("--debug") { return true }
    guard let value = ProcessInfo.processInfo.environment["DEBUG"]?.lowercased() else { return false }
    return ["1", "true", "yes", "on"].contains(value)
}()

// Probe Touch ID availability once at launch
let biometricsAvailable: Bool = {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/bioutil")
    process.arguments = ["-rs"]
    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = Pipe()
    do {
        try process.run()
        process.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        return process.terminationStatus == 0 && output.contains("Biometrics functionality: 1")
    } catch {
        return false
    }
}()

func debugLog(_ message: String) {
    if debugMode {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        print("[\(timestamp)] \(message)")
        fflush(stdout)
    }
}

// MARK: - Data Models

struct Option: Identifiable {
    let id = UUID()
    let label: String
    let script: String
    let description: String
    var isSelected: Bool
    let isPaid: Bool
    let isRequired: Bool
    let defaultSelected: Bool

    init(_ label: String, _ script: String, description: String = "", selected: Bool = true, paid: Bool = false, required: Bool = false) {
        self.label = label
        self.script = script
        self.description = description
        self.isPaid = paid
        self.isRequired = required
        self.defaultSelected = required ? true : (paid ? false : selected)
        self.isSelected = self.defaultSelected
    }
}

struct SubSection: Identifiable {
    let id = UUID()
    let name: String
    var options: [Option]
}

enum SidebarZone {
    case setup
    case apps
}

struct SidebarGroup: Identifiable {
    var id: String { name }
    let systemImage: String
    let name: String
    let zone: SidebarZone
    var subsections: [SubSection]

    var options: [Option] { subsections.flatMap { $0.options } }
    var selectedCount: Int { options.filter { $0.isSelected }.count }
}

struct InstallItem: Identifiable {
    let id = UUID()
    let label: String
    let script: String
    var status: InstallStatus = .pending
}

enum InstallStatus {
    case pending
    case running
    case success
    case error
}

enum Preset: String, CaseIterable {
    case minimal = "Minimal"
    case recommended = "Recommended"
    case developer = "Developer"
    case everything = "Everything"
    case nothing = "Nothing"
}

// MARK: - View Model

class AppState: ObservableObject {
    @Published var groups: [SidebarGroup] = [
        // ───────────────────────── SETUP ─────────────────────────
        SidebarGroup(systemImage: "gearshape.2", name: "Essentials", zone: .setup, subsections: [
            SubSection(name: "Prerequisites", options: [
                Option("Homebrew", "modules/homebrew/install.sh", description: "Package manager for macOS (telemetry disabled). Required by almost everything else.", required: true),
                Option("Git (update)", "modules/development/git.sh", description: "Latest Git via Homebrew instead of Apple's bundled version"),
            ]),
        ]),
        SidebarGroup(systemImage: "macwindow", name: "Desktop & Dock", zone: .setup, subsections: [
            SubSection(name: "Settings", options: [
                Option("Dock (36px, fast autohide)", "modules/system/dock.sh", description: "Small icons, show/hide without delay"),
                Option("Hide desktop icons", "modules/system/desktop.sh", description: "Clean desktop with no visible icons"),
                Option("Windows (no tile margins)", "modules/system/windows.sh", description: "Remove the gap between tiled windows (requires macOS 15+)"),
                Option("Expanded dialogs + save locally", "modules/system/dialogs.sh", description: "Save/print panels expanded, save to disk by default"),
            ]),
            SubSection(name: "Window Management", options: [
                Option("AltTab", "modules/windows/alttab.sh", description: "Windows-style Alt-Tab switcher with window previews"),
                Option("Rectangle", "modules/productivity/rectangle.sh", description: "Window manager with keyboard shortcuts", selected: false),
                Option("AeroSpace", "modules/windows/aerospace.sh", description: "i3-style tiling window manager", selected: false),
                Option("DockDoor", "modules/windows/dockdoor.sh", description: "Window previews when hovering the Dock", selected: false),
            ]),
            SubSection(name: "Menu Bar", options: [
                Option("Ice", "modules/menubar/ice.sh", description: "Hide and organize menu bar icons", selected: false),
                Option("Stats", "modules/menubar/stats.sh", description: "CPU, RAM and network monitor in the menu bar", selected: false),
                Option("Itsycal", "modules/menubar/itsycal.sh", description: "Tiny calendar in the menu bar", selected: false),
                Option("MeetingBar", "modules/menubar/meetingbar.sh", description: "Next meeting in the menu bar with one-click join", selected: false),
                Option("One Thing", "modules/menubar/one-thing.sh", description: "A single goal visible in the menu bar", selected: false),
            ]),
        ]),
        SidebarGroup(systemImage: "folder", name: "Finder & Files", zone: .setup, subsections: [
            SubSection(name: "Settings", options: [
                Option("Finder (extensions, path bar, local search)", "modules/system/finder.sh", description: "Show extensions, path bar and status bar; list view; search current folder; new windows open home"),
                Option("Screenshots (PNG, ~/Screenshots)", "modules/system/screenshot.sh", description: "PNG format, no thumbnail, saved to ~/Screenshots"),
                Option("No .DS_Store on network/USB", "modules/system/network.sh", description: "No .DS_Store on network/USB volumes; also enables AirDrop over Ethernet and disables Time Machine's new-disk prompt"),
            ]),
            SubSection(name: "Apps", options: [
                Option("Keka", "modules/utilities/keka.sh", description: "File archiver and extractor"),
                Option("AppCleaner", "modules/utilities/appcleaner.sh", description: "Uninstall apps completely", selected: false),
                Option("PearCleaner", "modules/utilities/pearcleaner.sh", description: "Open source app cleaner and system maintenance", selected: false),
                Option("GrandPerspective", "modules/utilities/grandperspective.sh", description: "Visualize disk usage as a treemap", selected: false),
                Option("yt-dlp", "modules/utilities/yt-dlp.sh", description: "Download video from YouTube and many other sites", selected: false),
                Option("Transmission", "modules/downloads/transmission.sh", description: "Lightweight, simple torrent client", selected: false),
                Option("qBittorrent", "modules/downloads/qbittorrent.sh", description: "Powerful ad-free torrent client", selected: false),
            ]),
        ]),
        SidebarGroup(systemImage: "keyboard", name: "Keyboard & Input", zone: .setup, subsections: [
            SubSection(name: "Settings", options: [
                Option("Disable autocorrection", "modules/system/input.sh", description: "No autocorrect, smart dashes, smart quotes or auto-capitalization"),
                Option("Disable Spotlight hotkey", "modules/system/spotlight-hotkey.sh", description: "Free up ⌘Space for Raycast or another launcher"),
            ]),
            SubSection(name: "Keyboard", options: [
                Option("Karabiner-Elements", "modules/keyboard/karabiner.sh", description: "Remap keys and create shortcuts", selected: false),
                Option("Espanso", "modules/keyboard/espanso.sh", description: "Open source cross-platform text expander", selected: false),
                Option("CheatSheet", "modules/keyboard/cheatsheet.sh", description: "See every app shortcut by holding ⌘", selected: false),
            ]),
            SubSection(name: "Mouse & Trackpad", options: [
                Option("SaneSideButtons", "modules/utilities/sanesidebuttons.sh", description: "Make mouse side buttons work for back/forward"),
                Option("Mos", "modules/input/mos.sh", description: "Smooth scrolling for external mice", selected: false),
                Option("LinearMouse", "modules/input/linearmouse.sh", description: "Advanced mouse and trackpad tuning", selected: false),
            ]),
            SubSection(name: "Automation", options: [
                Option("Hammerspoon", "modules/automation/hammerspoon.sh", description: "macOS automation with Lua scripting", selected: false),
                Option("Keyboard Maestro", "modules/automation/keyboard-maestro.sh", description: "Advanced macros and automation", paid: true),
                Option("BetterTouchTool", "modules/automation/bettertouchtool.sh", description: "Gestures, shortcuts and automation", paid: true),
            ]),
        ]),
        SidebarGroup(systemImage: "lock.shield", name: "Privacy & Security", zone: .setup, subsections: [
            SubSection(name: "Settings", options: [
                Option("Touch ID for sudo", "modules/system/terminal.sh", description: "Use your fingerprint for sudo commands", selected: biometricsAvailable),
                Option("Instant password after sleep", "modules/system/security.sh", description: "Require password immediately on wake"),
            ]),
            SubSection(name: "Security Tools", options: [
                Option("Sentinel", "modules/utilities/sentinel.sh", description: "Configure Gatekeeper, remove apps from quarantine and self-sign apps", selected: false),
                Option("LuLu", "modules/security/lulu.sh", description: "Open source outbound firewall", selected: false),
                Option("Little Snitch", "modules/utilities/little-snitch.sh", description: "Firewall with per-connection control", paid: true),
                Option("Oversight", "modules/security/oversight.sh", description: "Alerts when camera or microphone activate", selected: false),
                Option("Secretive", "modules/security/secretive.sh", description: "SSH keys stored in the Secure Enclave", selected: false),
            ]),
            SubSection(name: "Passwords", options: [
                Option("Bitwarden", "modules/security/bitwarden.sh", description: "Open source cloud password manager with a solid free tier", selected: false),
                Option("KeePassXC", "modules/security/keepassxc.sh", description: "Local-first open source password vault", selected: false),
                Option("1Password", "modules/security/1password.sh", description: "Polished password manager with SSH agent and passkeys", paid: true),
            ]),
            SubSection(name: "Networking", options: [
                Option("Tailscale", "modules/security/tailscale.sh", description: "Zero-config mesh VPN between your devices", selected: false),
            ]),
        ]),
        // ───────────────────────── APPS ─────────────────────────
        SidebarGroup(systemImage: "hammer", name: "Development", zone: .apps, subsections: [
            SubSection(name: "Editors", options: [
                Option("Visual Studio Code", "modules/development/vscode.sh", description: "Microsoft's code editor"),
                Option("Cursor", "modules/development/cursor.sh", description: "VS Code fork with built-in AI", selected: false),
            ]),
            SubSection(name: "AI", options: [
                Option("Claude Code", "modules/development/claude-code.sh", description: "AI coding agent in your terminal"),
                Option("Ollama", "modules/ai/ollama.sh", description: "Run LLMs locally", selected: false),
                Option("LM Studio", "modules/ai/lm-studio.sh", description: "GUI for local LLMs", selected: false),
            ]),
            SubSection(name: "Terminals", options: [
                Option("Warp", "modules/terminals/warp.sh", description: "Modern terminal with AI and collaboration"),
                Option("iTerm2", "modules/terminals/iterm.sh", description: "The classic feature-rich terminal", selected: false),
                Option("Ghostty", "modules/terminals/ghostty.sh", description: "Fast native terminal by Mitchell Hashimoto", selected: false),
                Option("Kitty", "modules/terminals/kitty.sh", description: "GPU-accelerated terminal with ligatures", selected: false),
                Option("Alacritty", "modules/terminals/alacritty.sh", description: "Minimal GPU-accelerated terminal", selected: false),
            ]),
            SubSection(name: "CLI Tools", options: [
                Option("mise", "modules/tools/mise.sh", description: "Polyglot runtime manager (replaces asdf/nvm/pyenv)"),
                Option("uv (Python)", "modules/tools/uv.sh", description: "Ultra-fast Python package and project manager"),
                Option("bun (JS/TS)", "modules/tools/bun.sh", description: "Fast all-in-one JavaScript runtime"),
                Option("ripgrep", "modules/tools/ripgrep.sh", description: "Blazing fast grep that respects .gitignore"),
                Option("fd", "modules/tools/fd.sh", description: "Fast and friendly find replacement"),
                Option("fzf", "modules/tools/fzf.sh", description: "Command-line fuzzy finder"),
                Option("jq", "modules/tools/jq.sh", description: "JSON processor for the command line"),
                Option("gh", "modules/tools/gh.sh", description: "Official GitHub CLI"),
                Option("bat", "modules/tools/bat.sh", description: "cat with syntax highlighting and git integration"),
                Option("eza", "modules/tools/eza.sh", description: "Modern ls with colors, icons and git status"),
                Option("zoxide", "modules/tools/zoxide.sh", description: "Smarter cd that learns your habits"),
                Option("lazygit", "modules/tools/lazygit.sh", description: "Terminal UI for git"),
                Option("starship", "modules/tools/starship.sh", description: "Fast, customizable cross-shell prompt"),
                Option("btop", "modules/tools/btop.sh", description: "Beautiful terminal resource monitor"),
                Option("git-delta", "modules/tools/git-delta.sh", description: "Syntax-highlighted side-by-side git diffs", selected: false),
                Option("atuin", "modules/tools/atuin.sh", description: "Searchable, syncable shell history", selected: false),
            ]),
            SubSection(name: "Apps & Services", options: [
                Option("OrbStack", "modules/development/orbstack.sh", description: "Fast, light Docker Desktop replacement with Linux VMs"),
                Option("Docker", "modules/development/docker.sh", description: "Docker Desktop for containers", selected: false),
                Option("GitHub Desktop", "modules/development/git.sh:desktop", description: "GUI client for GitHub"),
                Option("Fork", "modules/development/fork.sh", description: "Fast and polished git GUI", selected: false),
                Option("Bruno", "modules/development/bruno.sh", description: "Git-friendly offline API client", selected: false),
                Option("TablePlus", "modules/development/tableplus.sh", description: "Native database GUI", selected: false),
                Option("Platypus", "modules/development/platypus.sh", description: "Create macOS apps from scripts"),
                Option("FFmpeg", "modules/utilities/ffmpeg.sh", description: "Swiss-army knife for audio/video conversion"),
                Option("Cloudflared", "modules/utilities/cloudflared.sh", description: "Cloudflare tunnels from your machine"),
            ]),
        ]),
        SidebarGroup(systemImage: "bolt", name: "Productivity", zone: .apps, subsections: [
            SubSection(name: "Apps", options: [
                Option("Raycast", "modules/productivity/raycast.sh", description: "Launcher with superpowers: clipboard, snippets, extensions"),
                Option("Maccy", "modules/productivity/maccy.sh", description: "Lightweight keyboard-first clipboard manager"),
                Option("Shottr", "modules/productivity/shottr.sh", description: "Screenshots with scrolling capture, OCR and annotations"),
                Option("Superwhisper", "modules/productivity/superwhisper.sh", description: "Fast, accurate AI voice-to-text"),
                Option("Obsidian", "modules/notes/obsidian.sh", description: "Markdown knowledge base with links", selected: false),
                Option("Notion", "modules/notes/notion.sh", description: "All-in-one workspace", selected: false),
                Option("LibreOffice", "modules/productivity/libreoffice.sh", description: "Full open source office suite", selected: false),
            ]),
        ]),
        SidebarGroup(systemImage: "globe", name: "Internet & Comms", zone: .apps, subsections: [
            SubSection(name: "Browsers", options: [
                Option("Zen Browser", "modules/browsers/zen.sh", description: "Privacy-focused Firefox fork"),
                Option("Arc", "modules/browsers/arc.sh", description: "Modern browser with spaces and vertical tabs", selected: false),
                Option("Brave", "modules/browsers/brave.sh", description: "Chromium with built-in ad blocking", selected: false),
                Option("Firefox", "modules/browsers/firefox.sh", description: "Mozilla's open source browser", selected: false),
                Option("Orion", "modules/browsers/orion.sh", description: "Native WebKit with Chrome/Firefox extensions", selected: false),
                Option("Google Chrome", "modules/browsers/chrome.sh", description: "Google's browser", selected: false),
                Option("Helium", "modules/browsers/helium.sh", description: "Privacy-first lightweight Chromium-based browser", selected: false),
            ]),
            SubSection(name: "Messaging", options: [
                Option("WhatsApp", "modules/communication/whatsapp.sh", description: "Meta's messenger"),
                Option("Discord", "modules/communication/discord.sh", description: "Chat for communities and gaming"),
                Option("Telegram", "modules/communication/telegram.sh", description: "Fast, secure messaging", selected: false),
                Option("Slack", "modules/communication/slack.sh", description: "Team communication", selected: false),
                Option("Signal", "modules/communication/signal.sh", description: "Private, encrypted messaging", selected: false),
            ]),
            SubSection(name: "Email & Reading", options: [
                Option("Thunderbird", "modules/communication/thunderbird.sh", description: "Open source mail and calendar client", selected: false),
                Option("NetNewsWire", "modules/communication/netnewswire.sh", description: "Fast native open source RSS reader", selected: false),
            ]),
        ]),
        SidebarGroup(systemImage: "photo.on.rectangle.angled", name: "Media & Creative", zone: .apps, subsections: [
            SubSection(name: "Media", options: [
                Option("OBS", "modules/multimedia/obs.sh", description: "Video recording and streaming"),
                Option("IINA", "modules/multimedia/iina.sh", description: "Modern video player for macOS", selected: false),
                Option("VLC", "modules/multimedia/vlc.sh", description: "Universal media player", selected: false),
                Option("Kap", "modules/multimedia/kap.sh", description: "Screen recorder with quick GIF/MP4 export", selected: false),
            ]),
            SubSection(name: "Design", options: [
                Option("Figma", "modules/design/figma.sh", description: "Collaborative interface design", selected: false),
                Option("Blender", "modules/design/blender.sh", description: "Open source 3D suite", selected: false),
                Option("ImageOptim", "modules/design/imageoptim.sh", description: "Drag-and-drop image compression", selected: false),
                Option("Pika", "modules/design/pika.sh", description: "Native color picker with contrast checks", selected: false),
            ]),
            SubSection(name: "Gaming", options: [
                Option("Steam", "modules/gaming/steam.sh", description: "Valve's gaming platform", selected: false),
                Option("Epic Games", "modules/gaming/epic-games.sh", description: "Launcher with free weekly games", selected: false),
            ]),
        ]),
        SidebarGroup(systemImage: "wrench.and.screwdriver", name: "Utilities", zone: .apps, subsections: [
            SubSection(name: "Hardware & Display", options: [
                Option("MonitorControl", "modules/utilities/monitorcontrol.sh", description: "Control external display brightness/volume with native keys"),
                Option("BetterDisplay", "modules/utilities/betterdisplay.sh", description: "Custom resolutions, HiDPI and display management", selected: false),
                Option("AlDente", "modules/utilities/aldente.sh", description: "Battery charge limiter to extend battery lifespan", selected: false),
            ]),
            SubSection(name: "Quality of Life", options: [
                Option("KeepingYouAwake", "modules/utilities/keepingyouawake.sh", description: "Prevent sleep from the menu bar"),
                Option("Latest", "modules/utilities/latest.sh", description: "Check all installed apps for updates", selected: false),
            ]),
        ]),
        SidebarGroup(systemImage: "externaldrive", name: "Sync, Backup & VMs", zone: .apps, subsections: [
            SubSection(name: "Sync & Backup", options: [
                Option("Resilio Sync", "modules/utilities/resilio-sync.sh", description: "P2P file synchronization"),
                Option("Syncthing", "modules/backup/syncthing.sh", description: "Open source P2P synchronization", selected: false),
                Option("Dropbox", "modules/backup/dropbox.sh", description: "Cloud storage and sync", selected: false),
                Option("Backblaze", "modules/backup/backblaze.sh", description: "Unlimited cloud backup", paid: true),
            ]),
            SubSection(name: "Virtualization", options: [
                Option("UTM", "modules/vms/utm.sh", description: "Native VMs for Apple Silicon", selected: false),
                Option("VMware Fusion", "modules/vms/vmware-fusion.sh", description: "Professional virtualization", selected: false),
                Option("Parallels", "modules/vms/parallels.sh", description: "VMs optimized for Mac", paid: true),
            ]),
        ]),
    ]

    init() {
        // Hide Touch ID for sudo on machines without biometrics
        if !biometricsAvailable {
            for g in groups.indices {
                for s in groups[g].subsections.indices {
                    groups[g].subsections[s].options.removeAll { $0.script == "modules/system/terminal.sh" }
                }
            }
        }
    }

    @Published var selectedGroupID: String? = "Essentials"
    @Published var searchText: String = ""
    @Published var dryRun: Bool = false
    @Published var isInstalling: Bool = false
    @Published var installItems: [InstallItem] = []
    @Published var currentIndex: Int = 0
    @Published var installComplete: Bool = false
    @Published var errorCount: Int = 0

    var setupGroups: [SidebarGroup] { groups.filter { $0.zone == .setup } }
    var appGroups: [SidebarGroup] { groups.filter { $0.zone == .apps } }

    var selectedCount: Int {
        groups.flatMap { $0.options }.filter { $0.isSelected }.count
    }

    var totalCount: Int {
        groups.flatMap { $0.options }.count
    }

    // Indices of options matching the search text: (group, subsection, option)
    var searchMatches: [(g: Int, s: Int, o: Int, id: UUID)] {
        guard !searchText.isEmpty else { return [] }
        let query = searchText.lowercased()
        var result: [(Int, Int, Int, UUID)] = []
        for g in groups.indices {
            for s in groups[g].subsections.indices {
                for o in groups[g].subsections[s].options.indices {
                    let opt = groups[g].subsections[s].options[o]
                    if opt.label.lowercased().contains(query) || opt.description.lowercased().contains(query) {
                        result.append((g, s, o, opt.id))
                    }
                }
            }
        }
        return result
    }

    func enforceRequired() {
        for g in groups.indices {
            for s in groups[g].subsections.indices {
                for o in groups[g].subsections[s].options.indices {
                    if groups[g].subsections[s].options[o].isRequired && !groups[g].subsections[s].options[o].isSelected {
                        groups[g].subsections[s].options[o].isSelected = true
                    }
                }
            }
        }
    }

    func applyPreset(_ preset: Preset) {
        for g in groups.indices {
            let isDevGroup = groups[g].name == "Development"
            for s in groups[g].subsections.indices {
                for o in groups[g].subsections[s].options.indices {
                    let opt = groups[g].subsections[s].options[o]
                    let newValue: Bool
                    switch preset {
                    case .nothing:
                        newValue = opt.isRequired
                    case .everything:
                        newValue = true
                    case .recommended:
                        newValue = opt.defaultSelected
                    case .minimal:
                        newValue = opt.isRequired || (opt.script.hasPrefix("modules/system/") && opt.defaultSelected)
                    case .developer:
                        newValue = opt.defaultSelected || (isDevGroup && !opt.isPaid)
                    }
                    groups[g].subsections[s].options[o].isSelected = newValue
                }
            }
        }
        debugLog("🎛️ Applied preset: \(preset.rawValue) → \(selectedCount) selected")
    }

    func getSelectedOptions() -> [(label: String, script: String)] {
        groups.flatMap { $0.options }
            .filter { $0.isSelected }
            .map { ($0.label, $0.script) }
    }

    func startInstallation() {
        enforceRequired()
        let selected = getSelectedOptions()
        installItems = selected.map { InstallItem(label: $0.label, script: $0.script) }
        currentIndex = 0
        errorCount = 0
        installComplete = false
        isInstalling = true

        debugLog("🚀 Starting installation with \(installItems.count) items")
        debugLog("🔧 Dry run: \(dryRun)")
        for (index, item) in installItems.enumerated() {
            debugLog("  [\(index + 1)] \(item.label) → \(item.script)")
        }

        runNextItem()
    }

    func runNextItem() {
        guard currentIndex < installItems.count else {
            debugLog("✅ Installation complete. Errors: \(errorCount)")
            installComplete = true
            return
        }

        installItems[currentIndex].status = .running

        let item = installItems[currentIndex]
        let scriptPath = item.script.components(separatedBy: ":").first ?? item.script
        let scriptArg = item.script.contains(":") ? item.script.components(separatedBy: ":").last ?? "" : ""

        // Get script directory
        let scriptDir = ProcessInfo.processInfo.environment["MACPREPARE_DIR"] ?? FileManager.default.currentDirectoryPath

        debugLog("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        debugLog("📦 [\(currentIndex + 1)/\(installItems.count)] \(item.label)")

        DispatchQueue.global(qos: .userInitiated).async {
            let success: Bool

            if self.dryRun {
                // Simulate delay for dry run
                debugLog("🧪 DRY RUN - Simulating success")
                Thread.sleep(forTimeInterval: 0.1)
                success = true
            } else {
                success = self.executeScript(scriptDir: scriptDir, scriptPath: scriptPath, arg: scriptArg)
            }

            DispatchQueue.main.async {
                self.installItems[self.currentIndex].status = success ? .success : .error
                if !success {
                    self.errorCount += 1
                }
                self.currentIndex += 1
                self.runNextItem()
            }
        }
    }

    func executeScript(scriptDir: String, scriptPath: String, arg: String) -> Bool {
        let fullPath = "\(scriptDir)/\(scriptPath)"

        debugLog("📂 Script dir: \(scriptDir)")
        debugLog("📄 Script path: \(scriptPath)")
        debugLog("📄 Full path: \(fullPath)")
        debugLog("🔧 Arg: \(arg.isEmpty ? "(none)" : arg)")

        // Check if script exists
        if !FileManager.default.fileExists(atPath: fullPath) {
            debugLog("❌ ERROR: Script not found at \(fullPath)")
            return false
        }

        // Only Touch ID for sudo genuinely needs root (writes /etc/pam.d/sudo_local).
        // All other system scripts are per-user `defaults` writes and must NOT run as root:
        // elevating them would write root's preference domain and spam password prompts.
        let needsAdmin = scriptPath == "modules/system/terminal.sh"

        let utilsPath = "\(scriptDir)/lib/utils.sh"
        let shellCommand = arg.isEmpty
            ? "source '\(utilsPath)' 2>/dev/null; source '\(fullPath)'"
            : "source '\(utilsPath)' 2>/dev/null; source '\(fullPath)' '\(arg)'"

        if needsAdmin {
            debugLog("🔐 Running with administrator privileges")
            return executeWithAdmin(command: shellCommand, scriptDir: scriptDir)
        } else {
            debugLog("🚀 Running normally")
            return executeNormally(command: shellCommand, scriptDir: scriptDir)
        }
    }

    // Runs a configured process, draining stdout/stderr concurrently to avoid
    // pipe-buffer deadlocks with verbose child output.
    func runProcess(_ process: Process) -> Bool {
        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        process.standardOutput = stdoutPipe
        process.standardError = stderrPipe

        var stdoutData = Data()
        var stderrData = Data()
        let ioQueue = DispatchQueue(label: "macprepare.pipes")
        let ioGroup = DispatchGroup()

        stdoutPipe.fileHandleForReading.readabilityHandler = { handle in
            let chunk = handle.availableData
            if chunk.isEmpty { return }
            ioQueue.async { stdoutData.append(chunk) }
        }
        stderrPipe.fileHandleForReading.readabilityHandler = { handle in
            let chunk = handle.availableData
            if chunk.isEmpty { return }
            ioQueue.async { stderrData.append(chunk) }
        }

        do {
            try process.run()
            process.waitUntilExit()

            // Read any remaining buffered data, then stop the handlers
            stdoutPipe.fileHandleForReading.readabilityHandler = nil
            stderrPipe.fileHandleForReading.readabilityHandler = nil
            let stdoutRest = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
            let stderrRest = stderrPipe.fileHandleForReading.readDataToEndOfFile()
            ioGroup.enter()
            ioQueue.async {
                stdoutData.append(stdoutRest)
                stderrData.append(stderrRest)
                ioGroup.leave()
            }
            ioGroup.wait()

            if let stdout = String(data: stdoutData, encoding: .utf8), !stdout.isEmpty {
                debugLog("📤 STDOUT:\n\(stdout)")
            }
            if let stderr = String(data: stderrData, encoding: .utf8), !stderr.isEmpty {
                debugLog("⚠️ STDERR:\n\(stderr)")
            }

            let success = process.terminationStatus == 0
            debugLog(success ? "✅ Exit code: 0 (success)" : "❌ Exit code: \(process.terminationStatus) (error)")

            return success
        } catch {
            stdoutPipe.fileHandleForReading.readabilityHandler = nil
            stderrPipe.fileHandleForReading.readabilityHandler = nil
            debugLog("❌ ERROR: Failed to run process: \(error.localizedDescription)")
            return false
        }
    }

    func executeWithAdmin(command: String, scriptDir: String) -> Bool {
        // Write command to temp script file to avoid escaping issues
        let tempScript = "/tmp/macprepare-admin-\(UUID().uuidString).sh"
        let scriptContent = """
        #!/bin/bash
        cd '\(scriptDir)'
        export PATH='/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
        \(command)
        """

        do {
            try scriptContent.write(toFile: tempScript, atomically: true, encoding: .utf8)
            try FileManager.default.setAttributes([.posixPermissions: 0o700], ofItemAtPath: tempScript)
        } catch {
            debugLog("❌ ERROR: Failed to create temp script: \(error)")
            return false
        }

        defer { try? FileManager.default.removeItem(atPath: tempScript) }

        // Use osascript with administrator privileges (shows native macOS auth dialog)
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
        process.arguments = ["-e", "do shell script \"\(tempScript)\" with administrator privileges"]

        return runProcess(process)
    }

    func executeNormally(command: String, scriptDir: String) -> Bool {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/zsh")
        process.arguments = ["-c", command]
        process.currentDirectoryURL = URL(fileURLWithPath: scriptDir)

        var env = ProcessInfo.processInfo.environment
        env["PATH"] = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        process.environment = env

        return runProcess(process)
    }
}

// MARK: - App Delegate

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if debugMode {
            print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
            print("🍎 MacPrepare v3 - DEBUG MODE ENABLED")
            print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
            print("📂 Working dir: \(FileManager.default.currentDirectoryPath)")
            print("📂 MACPREPARE_DIR: \(ProcessInfo.processInfo.environment["MACPREPARE_DIR"] ?? "(not set)")")
            print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
            fflush(stdout)
        }

        NSApp.setActivationPolicy(.regular)

        if let window = NSApplication.shared.windows.first {
            window.center()
            window.makeKeyAndOrderFront(nil)
        }
        NSApplication.shared.activate(ignoringOtherApps: true)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

// MARK: - Views

struct OptionRow: View {
    @Binding var option: Option

    var body: some View {
        Toggle(isOn: $option.isSelected) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(option.label)
                        .font(.system(size: 13))
                    if option.isPaid {
                        Text("PAID")
                            .font(.system(size: 9, weight: .semibold))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color.orange.opacity(0.2))
                            .foregroundColor(.orange)
                            .cornerRadius(3)
                    }
                    if option.isRequired {
                        Text("REQUIRED")
                            .font(.system(size: 9, weight: .semibold))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color.secondary.opacity(0.15))
                            .foregroundColor(.secondary)
                            .cornerRadius(3)
                    }
                }
                if !option.description.isEmpty {
                    Text(option.description)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .toggleStyle(.checkbox)
        .disabled(option.isRequired)
    }
}

struct GroupDetailView: View {
    @ObservedObject var state: AppState
    let groupIndex: Int

    var body: some View {
        Form {
            ForEach($state.groups[groupIndex].subsections) { $sub in
                Section {
                    ForEach($sub.options) { $option in
                        OptionRow(option: $option)
                    }
                } header: {
                    HStack {
                        Text(sub.name)
                        Spacer()
                        Toggle("All", sources: $sub.options, isOn: \.isSelected)
                            .toggleStyle(.checkbox)
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .formStyle(.grouped)
        .onChange(of: state.selectedCount) {
            state.enforceRequired()
        }
    }
}

struct SearchResultsView: View {
    @ObservedObject var state: AppState

    var body: some View {
        let matches = state.searchMatches
        Form {
            Section {
                if matches.isEmpty {
                    Text("No results for “\(state.searchText)”")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(matches, id: \.id) { match in
                        OptionRow(option: $state.groups[match.g].subsections[match.s].options[match.o])
                    }
                }
            } header: {
                Text("Search results (\(matches.count))")
            }
        }
        .formStyle(.grouped)
    }
}

struct SidebarView: View {
    @ObservedObject var state: AppState

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.system(size: 12))
                TextField("Search", text: $state.searchText)
                    .textFieldStyle(.plain)
                    .font(.system(size: 12))
                if !state.searchText.isEmpty {
                    Button {
                        state.searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .font(.system(size: 11))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(6)
            .background(Color(NSColor.textBackgroundColor).opacity(0.5))
            .cornerRadius(6)
            .padding(.horizontal, 10)
            .padding(.top, 8)

            List(selection: $state.selectedGroupID) {
                Section("Setup") {
                    ForEach(state.setupGroups) { group in
                        Label(group.name, systemImage: group.systemImage)
                            .badge(group.selectedCount)
                            .tag(group.id)
                    }
                }
                Section("Apps") {
                    ForEach(state.appGroups) { group in
                        Label(group.name, systemImage: group.systemImage)
                            .badge(group.selectedCount)
                            .tag(group.id)
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}

struct SelectionView: View {
    @ObservedObject var state: AppState

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                HStack(spacing: 6) {
                    Text("🍎")
                        .font(.system(size: 16))
                    Text("MacPrepare")
                        .font(.system(size: 16, weight: .bold))
                }

                Spacer()

                HStack(spacing: 8) {
                    Text("Preset:")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                    ForEach(Preset.allCases, id: \.self) { preset in
                        Button(preset.rawValue) {
                            state.applyPreset(preset)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                    }

                    Divider()
                        .frame(height: 16)

                    Toggle("Dry Run", isOn: $state.dryRun)
                        .toggleStyle(.checkbox)
                        .font(.system(size: 11))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)

            Divider()

            NavigationSplitView {
                SidebarView(state: state)
                    .navigationSplitViewColumnWidth(min: 200, ideal: 220, max: 260)
            } detail: {
                if !state.searchText.isEmpty {
                    SearchResultsView(state: state)
                } else if let id = state.selectedGroupID,
                          let index = state.groups.firstIndex(where: { $0.id == id }) {
                    GroupDetailView(state: state, groupIndex: index)
                } else {
                    Text("Select a category")
                        .foregroundColor(.secondary)
                }
            }

            Divider()

            // Footer
            HStack {
                Text("\(state.selectedCount) of \(state.totalCount) selected")
                    .foregroundColor(.secondary)
                    .font(.system(size: 11))

                Spacer()

                Button("Cancel") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut(.cancelAction)
                .controlSize(.regular)

                Button("Install") {
                    state.startInstallation()
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
                .controlSize(.regular)
                .disabled(state.selectedCount == 0)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .frame(minWidth: 940, minHeight: 680)
    }
}

struct InstallItemRow: View {
    let item: InstallItem

    var body: some View {
        HStack(spacing: 10) {
            // Status icon
            Group {
                switch item.status {
                case .pending:
                    Image(systemName: "circle")
                        .foregroundColor(.secondary)
                case .running:
                    ProgressView()
                        .scaleEffect(0.6)
                        .frame(width: 16, height: 16)
                case .success:
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                case .error:
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                }
            }
            .frame(width: 20)

            Text(item.label)
                .font(.system(size: 12))
                .foregroundColor(item.status == .pending ? .secondary : .primary)

            Spacer()
        }
        .padding(.vertical, 2)
    }
}

struct ProgressView_Install: View {
    @ObservedObject var state: AppState

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("🍎")
                    .font(.system(size: 18))
                Text(state.installComplete ? "Installation Complete" : "Installing...")
                    .font(.system(size: 18, weight: .bold))
                Spacer()

                if state.dryRun {
                    Text("DRY RUN")
                        .font(.system(size: 10, weight: .semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.orange.opacity(0.2))
                        .foregroundColor(.orange)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)

            Divider()

            // Progress bar
            VStack(spacing: 8) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 8)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.accentColor)
                            .frame(width: geo.size.width * progress, height: 8)
                    }
                }
                .frame(height: 8)

                Text("\(completedCount) of \(state.installItems.count) completed")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)

            Divider()

            // Items list
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(Array(state.installItems.enumerated()), id: \.element.id) { index, item in
                            InstallItemRow(item: item)
                                .id(index)
                        }
                    }
                    .padding(16)
                }
                .onChange(of: state.currentIndex) { _, newIndex in
                    withAnimation {
                        proxy.scrollTo(max(0, newIndex - 2), anchor: .top)
                    }
                }
            }

            Divider()

            // Footer
            HStack {
                if state.installComplete {
                    if state.errorCount > 0 {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text("\(state.errorCount) errors")
                            .font(.system(size: 11))
                            .foregroundColor(.orange)
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Everything installed successfully")
                            .font(.system(size: 11))
                            .foregroundColor(.green)
                    }
                }

                Spacer()

                Button(state.installComplete ? "Close" : "Cancel") {
                    NSApplication.shared.terminate(nil)
                }
                .controlSize(.regular)
                .keyboardShortcut(state.installComplete ? .defaultAction : .cancelAction)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .frame(minWidth: 940, minHeight: 680)
    }

    var completedCount: Int {
        state.installItems.filter { $0.status == .success || $0.status == .error }.count
    }

    var progress: CGFloat {
        guard !state.installItems.isEmpty else { return 0 }
        return CGFloat(completedCount) / CGFloat(state.installItems.count)
    }
}

struct ContentView: View {
    @StateObject private var state = AppState()

    var body: some View {
        Group {
            if state.isInstalling {
                ProgressView_Install(state: state)
            } else {
                SelectionView(state: state)
            }
        }
        .onAppear {
            // Get script directory from environment or use current
            if let dir = ProcessInfo.processInfo.environment["MACPREPARE_DIR"] {
                FileManager.default.changeCurrentDirectoryPath(dir)
            }
        }
    }
}

// MARK: - App Entry Point

@main
struct MacPrepareApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
    }
}
