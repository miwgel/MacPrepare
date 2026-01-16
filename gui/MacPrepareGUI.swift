import SwiftUI
import AppKit

// MARK: - Debug Mode

let debugMode = ProcessInfo.processInfo.environment["DEBUG"] != nil || CommandLine.arguments.contains("--debug")

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

    init(_ label: String, _ script: String, description: String = "", selected: Bool = true, paid: Bool = false) {
        self.label = label
        self.script = script
        self.description = description
        self.isSelected = paid ? false : selected
        self.isPaid = paid
    }
}

struct Category: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
    var options: [Option]
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

// MARK: - View Model

class AppState: ObservableObject {
    @Published var categories: [Category] = [
        // ⚙️ Sistema (11 opciones)
        Category(icon: "⚙️", name: "Sistema", options: [
            Option("Teclado Spanish Better QWERTY", "modules/system/keyboard.sh", description: "Layout QWERTY con ñ y acentos fáciles usando Option"),
            Option("Dock (36px, autohide rápido)", "modules/system/dock.sh", description: "Iconos pequeños, aparece/desaparece sin delay"),
            Option("Finder (extensiones, path bar, buscar local)", "modules/system/finder.sh", description: "Mostrar extensiones, barra de ruta, búsqueda en carpeta actual"),
            Option("Escritorio (ocultar iconos)", "modules/system/desktop.sh", description: "Escritorio limpio sin iconos visibles"),
            Option("Ventanas (sin márgenes, resize rápido)", "modules/system/windows.sh", description: "Tiles sin separación, resize instantáneo"),
            Option("Capturas (PNG, ~/Screenshots)", "modules/system/screenshot.sh", description: "Formato PNG, sin thumbnail, guardadas en ~/Screenshots"),
            Option("TouchID para sudo", "modules/system/terminal.sh", description: "Usar huella digital para comandos sudo"),
            Option("Desactivar autocorrección", "modules/system/input.sh", description: "Sin autocorrección, smart dashes, quotes ni capitalización automática"),
            Option("Password instantáneo tras sleep", "modules/system/security.sh", description: "Pedir contraseña inmediatamente al despertar"),
            Option("Diálogos expandidos + guardar local", "modules/system/dialogs.sh", description: "Paneles de guardar/imprimir expandidos, guardar en disco local"),
            Option("No .DS_Store en red/USB", "modules/system/network.sh", description: "Sin archivos .DS_Store en volúmenes de red y USB"),
            Option("Desactivar Spotlight hotkey", "modules/system/spotlight-hotkey.sh", description: "Libera ⌘Space para usar con Raycast u otro launcher"),
        ]),
        // 🍺 Homebrew (1 opción)
        Category(icon: "🍺", name: "Homebrew", options: [
            Option("Instalar + desactivar telemetría", "modules/homebrew/install.sh", description: "Gestor de paquetes para macOS sin analytics"),
        ]),
        // 🛠️ Herramientas (2 opciones)
        Category(icon: "🛠️", name: "Herramientas", options: [
            Option("uv (Python)", "modules/tools/uv.sh", description: "Gestor ultrarrápido de Python y paquetes"),
            Option("bun (JS/TS)", "modules/tools/bun.sh", description: "Runtime JS/TS moderno, rápido y todo-en-uno"),
        ]),
        // 🖥️ Terminales (5 opciones)
        Category(icon: "🖥️", name: "Terminales", options: [
            Option("Warp", "modules/terminals/warp.sh", description: "Terminal moderna con AI y colaboración"),
            Option("iTerm2", "modules/terminals/iterm.sh", description: "Terminal clásica con muchas funciones", selected: false),
            Option("Ghostty", "modules/terminals/ghostty.sh", description: "Terminal nativa rápida de Mitchell Hashimoto", selected: false),
            Option("Kitty", "modules/terminals/kitty.sh", description: "Terminal GPU-acelerada con ligatures", selected: false),
            Option("Alacritty", "modules/terminals/alacritty.sh", description: "Terminal minimalista GPU-acelerada", selected: false),
        ]),
        // 💻 Desarrollo (6 opciones)
        Category(icon: "💻", name: "Desarrollo", options: [
            Option("Visual Studio Code", "modules/development/vscode.sh", description: "Editor de código de Microsoft"),
            Option("Cursor", "modules/development/cursor.sh", description: "VS Code fork con AI integrado", selected: false),
            Option("Git (actualizar)", "modules/development/git.sh", description: "Sistema de control de versiones"),
            Option("GitHub Desktop", "modules/development/git.sh:desktop", description: "Cliente GUI para GitHub"),
            Option("Docker", "modules/development/docker.sh", description: "Contenedores para desarrollo"),
            Option("Platypus", "modules/development/platypus.sh", description: "Crear apps macOS desde scripts"),
        ]),
        // 🚀 Productividad (4 opciones)
        Category(icon: "🚀", name: "Productividad", options: [
            Option("Raycast", "modules/productivity/raycast.sh", description: "Launcher con superpoderes: clipboard, snippets, extensiones"),
            Option("Superwhisper", "modules/productivity/superwhisper.sh", description: "Voz a texto con AI, rápido y preciso"),
            Option("Claude Code", "modules/development/claude-code.sh", description: "Agente de código AI en tu terminal"),
            Option("Rectangle", "modules/productivity/rectangle.sh", description: "Window manager con atajos de teclado", selected: false),
        ]),
        // 📊 Menu Bar (4 opciones)
        Category(icon: "📊", name: "Menu Bar", options: [
            Option("Ice", "modules/menubar/ice.sh", description: "Ocultar iconos del menu bar", selected: false),
            Option("One Thing", "modules/menubar/one-thing.sh", description: "Un solo objetivo visible en menu bar", selected: false),
            Option("Itsycal", "modules/menubar/itsycal.sh", description: "Pequeño calendario en menu bar", selected: false),
            Option("Stats", "modules/menubar/stats.sh", description: "Monitor de CPU, RAM, red en menu bar", selected: false),
        ]),
        // 🪟 Windows (2 opciones)
        Category(icon: "🪟", name: "Windows", options: [
            Option("AeroSpace", "modules/windows/aerospace.sh", description: "Tiling window manager estilo i3", selected: false),
            Option("DockDoor", "modules/windows/dockdoor.sh", description: "Preview de ventanas en el Dock", selected: false),
        ]),
        // 📝 Notas (2 opciones)
        Category(icon: "📝", name: "Notas", options: [
            Option("Obsidian", "modules/notes/obsidian.sh", description: "Base de conocimiento con Markdown y links", selected: false),
            Option("Notion", "modules/notes/notion.sh", description: "Workspace todo-en-uno", selected: false),
        ]),
        // 🌐 Navegadores (6 opciones)
        Category(icon: "🌐", name: "Navegadores", options: [
            Option("Zen Browser", "modules/browsers/zen.sh", description: "Firefox fork enfocado en privacidad"),
            Option("Arc", "modules/browsers/arc.sh", description: "Navegador moderno con espacios y pestañas verticales", selected: false),
            Option("Brave", "modules/browsers/brave.sh", description: "Chromium con bloqueo de ads integrado", selected: false),
            Option("Firefox", "modules/browsers/firefox.sh", description: "Navegador open source de Mozilla", selected: false),
            Option("Orion", "modules/browsers/orion.sh", description: "WebKit nativo con extensiones Chrome/Firefox", selected: false),
            Option("Google Chrome", "modules/browsers/chrome.sh", description: "Navegador de Google", selected: false),
        ]),
        // 🛠️ Utilidades (muchas opciones)
        Category(icon: "🔧", name: "Utilidades", options: [
            Option("Sentinel", "modules/utilities/sentinel.sh", description: "Monitor de permisos y privacidad"),
            Option("Keka", "modules/utilities/keka.sh", description: "Compresor/descompresor de archivos"),
            Option("FFMPEG", "modules/utilities/ffmpeg.sh", description: "Herramienta de conversión multimedia"),
            Option("Cloudflared", "modules/utilities/cloudflared.sh", description: "Túneles Cloudflare"),
            Option("SaneSideButtons", "modules/utilities/sanesidebuttons.sh", description: "Botones laterales del ratón funcionan"),
            Option("Resilio Sync", "modules/utilities/resilio-sync.sh", description: "Sincronización P2P de archivos"),
            Option("AppCleaner", "modules/utilities/appcleaner.sh", description: "Desinstalar apps completamente", selected: false),
            Option("GrandPerspective", "modules/utilities/grandperspective.sh", description: "Visualizar uso de disco", selected: false),
            Option("PearCleaner", "modules/utilities/pearcleaner.sh", description: "Limpieza de sistema open source", selected: false),
            Option("yt-dlp", "modules/utilities/yt-dlp.sh", description: "Descargar videos de YouTube y más", selected: false),
            Option("Little Snitch", "modules/utilities/little-snitch.sh", description: "Firewall con control de conexiones", paid: true),
        ]),
        // 💬 Comunicación (5 opciones)
        Category(icon: "💬", name: "Comunicación", options: [
            Option("WhatsApp", "modules/communication/whatsapp.sh", description: "Mensajería de Meta"),
            Option("Discord", "modules/communication/discord.sh", description: "Chat para comunidades y gaming"),
            Option("Telegram", "modules/communication/telegram.sh", description: "Mensajería rápida y segura", selected: false),
            Option("Slack", "modules/communication/slack.sh", description: "Comunicación para equipos", selected: false),
            Option("Signal", "modules/communication/signal.sh", description: "Mensajería privada encriptada", selected: false),
        ]),
        // 🎬 Multimedia (3 opciones)
        Category(icon: "🎬", name: "Multimedia", options: [
            Option("OBS", "modules/multimedia/obs.sh", description: "Grabación y streaming de video"),
            Option("IINA", "modules/multimedia/iina.sh", description: "Reproductor de video moderno para macOS", selected: false),
            Option("VLC", "modules/multimedia/vlc.sh", description: "Reproductor multimedia universal", selected: false),
        ]),
        // ⚡ Automatización (3 opciones)
        Category(icon: "⚡", name: "Automatización", options: [
            Option("Hammerspoon", "modules/automation/hammerspoon.sh", description: "Automatización con Lua scripting", selected: false),
            Option("Keyboard Maestro", "modules/automation/keyboard-maestro.sh", description: "Macros y automatización avanzada", selected: false, paid: true),
            Option("BetterTouchTool", "modules/automation/bettertouchtool.sh", description: "Gestos, atajos y automatización", selected: false, paid: true),
        ]),
        // 💾 Backup (3 opciones)
        Category(icon: "💾", name: "Backup", options: [
            Option("Syncthing", "modules/backup/syncthing.sh", description: "Sincronización P2P open source", selected: false),
            Option("Backblaze", "modules/backup/backblaze.sh", description: "Backup ilimitado en la nube", selected: false, paid: true),
            Option("Dropbox", "modules/backup/dropbox.sh", description: "Almacenamiento y sincronización cloud", selected: false),
        ]),
        // 🖥️ VMs (3 opciones)
        Category(icon: "🖥️", name: "Virtualización", options: [
            Option("UTM", "modules/vms/utm.sh", description: "VMs nativas para Apple Silicon", selected: false),
            Option("VMware Fusion", "modules/vms/vmware-fusion.sh", description: "Virtualización profesional", selected: false),
            Option("Parallels", "modules/vms/parallels.sh", description: "VMs optimizadas para Mac", selected: false, paid: true),
        ]),
        // 🔒 Seguridad (3 opciones)
        Category(icon: "🔒", name: "Seguridad", options: [
            Option("LuLu", "modules/security/lulu.sh", description: "Firewall open source", selected: false),
            Option("Oversight", "modules/security/oversight.sh", description: "Alertas de cámara y micrófono", selected: false),
            Option("Secretive", "modules/security/secretive.sh", description: "SSH keys en Secure Enclave", selected: false),
        ]),
        // 🖱️ Input (2 opciones)
        Category(icon: "🖱️", name: "Input", options: [
            Option("Mos", "modules/input/mos.sh", description: "Scroll suave para ratones externos", selected: false),
            Option("LinearMouse", "modules/input/linearmouse.sh", description: "Ajustes avanzados de ratón/trackpad", selected: false),
        ]),
        // ⌨️ Teclado (2 opciones)
        Category(icon: "⌨️", name: "Teclado", options: [
            Option("Karabiner-Elements", "modules/keyboard/karabiner.sh", description: "Remapear teclas y crear atajos", selected: false),
            Option("CheatSheet", "modules/keyboard/cheatsheet.sh", description: "Ver todos los atajos manteniendo ⌘", selected: false),
        ]),
        // 🤖 AI Local (2 opciones)
        Category(icon: "🤖", name: "AI Local", options: [
            Option("Ollama", "modules/ai/ollama.sh", description: "Ejecutar LLMs localmente", selected: false),
            Option("LM Studio", "modules/ai/lm-studio.sh", description: "GUI para LLMs locales", selected: false),
        ]),
        // 📥 Descargas (2 opciones)
        Category(icon: "📥", name: "Descargas", options: [
            Option("qBittorrent", "modules/downloads/qbittorrent.sh", description: "Cliente torrent potente sin ads", selected: false),
            Option("Transmission", "modules/downloads/transmission.sh", description: "Cliente torrent ligero y simple", selected: false),
        ]),
        // 🎨 Diseño (2 opciones)
        Category(icon: "🎨", name: "Diseño", options: [
            Option("Figma", "modules/design/figma.sh", description: "Diseño de interfaces colaborativo", selected: false),
            Option("Blender", "modules/design/blender.sh", description: "Suite 3D open source", selected: false),
        ]),
        // 🎮 Gaming (2 opciones)
        Category(icon: "🎮", name: "Gaming", options: [
            Option("Steam", "modules/gaming/steam.sh", description: "Plataforma de juegos de Valve", selected: false),
            Option("Epic Games", "modules/gaming/epic-games.sh", description: "Launcher con juegos gratis semanales", selected: false),
        ]),
    ]

    @Published var dryRun: Bool = false
    @Published var isInstalling: Bool = false
    @Published var installItems: [InstallItem] = []
    @Published var currentIndex: Int = 0
    @Published var installComplete: Bool = false
    @Published var errorCount: Int = 0

    var selectedCount: Int {
        categories.flatMap { $0.options }.filter { $0.isSelected }.count
    }

    var totalCount: Int {
        categories.flatMap { $0.options }.count
    }

    func selectAll() {
        for i in categories.indices {
            for j in categories[i].options.indices {
                categories[i].options[j].isSelected = true
            }
        }
    }

    func selectNone() {
        for i in categories.indices {
            for j in categories[i].options.indices {
                categories[i].options[j].isSelected = false
            }
        }
    }

    func getSelectedOptions() -> [(label: String, script: String)] {
        categories.flatMap { $0.options }
            .filter { $0.isSelected }
            .map { ($0.label, $0.script) }
    }

    func startInstallation() {
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

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/zsh")

        let utilsPath = "\(scriptDir)/lib/utils.sh"
        let command = arg.isEmpty
            ? "source '\(utilsPath)' 2>/dev/null; source '\(fullPath)'"
            : "source '\(utilsPath)' 2>/dev/null; source '\(fullPath)' '\(arg)'"

        debugLog("🚀 Command: \(command)")

        process.arguments = ["-c", command]
        process.currentDirectoryURL = URL(fileURLWithPath: scriptDir)

        // Set environment
        var env = ProcessInfo.processInfo.environment
        env["PATH"] = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        process.environment = env

        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        process.standardOutput = stdoutPipe
        process.standardError = stderrPipe

        do {
            try process.run()
            process.waitUntilExit()

            let stdoutData = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
            let stderrData = stderrPipe.fileHandleForReading.readDataToEndOfFile()

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
            debugLog("❌ ERROR: Failed to run process: \(error.localizedDescription)")
            return false
        }
    }
}

// MARK: - App Delegate

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if debugMode {
            print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
            print("🍎 MacPrepare v2 - DEBUG MODE ENABLED")
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
            HStack(spacing: 4) {
                Text(option.label)
                    .font(.system(size: 12))
                    .foregroundColor(option.isPaid ? .secondary : .primary)
                if option.isPaid {
                    Text("(pago)")
                        .font(.system(size: 10))
                        .foregroundColor(.orange)
                }
            }
        }
        .toggleStyle(.checkbox)
        .help(option.description)
    }
}

struct CategoryCard: View {
    @Binding var category: Category

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Text(category.icon)
                    .font(.system(size: 13))
                Text(category.name)
                    .font(.system(size: 12, weight: .semibold))
            }

            VStack(alignment: .leading, spacing: 4) {
                ForEach($category.options) { $option in
                    OptionRow(option: $option)
                }
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
    }
}

struct InstallItemRow: View {
    let item: InstallItem
    let index: Int
    let total: Int

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
                Text(state.installComplete ? "Instalación Completada" : "Instalando...")
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

                Text("\(completedCount)/\(state.installItems.count) completados")
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
                            InstallItemRow(item: item, index: index, total: state.installItems.count)
                                .id(index)
                        }
                    }
                    .padding(16)
                }
                .onChange(of: state.currentIndex) { newIndex in
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
                        Text("\(state.errorCount) errores")
                            .font(.system(size: 11))
                            .foregroundColor(.orange)
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Todo instalado correctamente")
                            .font(.system(size: 11))
                            .foregroundColor(.green)
                    }
                }

                Spacer()

                Button(state.installComplete ? "Cerrar" : "Cancelar") {
                    NSApplication.shared.terminate(nil)
                }
                .controlSize(.regular)
                .keyboardShortcut(state.installComplete ? .defaultAction : .cancelAction)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .frame(width: 900, height: 700)
    }

    var completedCount: Int {
        state.installItems.filter { $0.status == .success || $0.status == .error }.count
    }

    var progress: CGFloat {
        guard !state.installItems.isEmpty else { return 0 }
        return CGFloat(completedCount) / CGFloat(state.installItems.count)
    }
}

struct SelectionView: View {
    @ObservedObject var state: AppState

    // Column 1: Sistema, Homebrew, Herramientas, Terminales, Desarrollo, Productividad, Menu Bar
    var column1: [Binding<Category>] {
        Array($state.categories[0..<7])
    }

    // Column 2: Windows, Notas, Navegadores, Utilidades, Comunicación, Multimedia
    var column2: [Binding<Category>] {
        Array($state.categories[7..<13])
    }

    // Column 3: Automatización, Backup, VMs, Seguridad, Input, Teclado, AI, Descargas, Diseño, Gaming
    var column3: [Binding<Category>] {
        Array($state.categories[13..<21])
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                HStack(spacing: 6) {
                    Text("🍎")
                        .font(.system(size: 18))
                    Text("MacPrepare v2")
                        .font(.system(size: 18, weight: .bold))
                }

                Spacer()

                HStack(spacing: 10) {
                    Button("Todo") { state.selectAll() }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                    Button("Nada") { state.selectNone() }
                        .buttonStyle(.bordered)
                        .controlSize(.small)

                    Divider()
                        .frame(height: 16)

                    Toggle("Dry Run", isOn: $state.dryRun)
                        .toggleStyle(.checkbox)
                        .font(.system(size: 11))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider()

            // Content - 3 columns with scroll
            ScrollView {
                HStack(alignment: .top, spacing: 10) {
                    VStack(spacing: 8) {
                        ForEach(column1) { $category in
                            CategoryCard(category: $category)
                        }
                    }
                    .frame(maxWidth: .infinity)

                    VStack(spacing: 8) {
                        ForEach(column2) { $category in
                            CategoryCard(category: $category)
                        }
                    }
                    .frame(maxWidth: .infinity)

                    VStack(spacing: 8) {
                        ForEach(column3) { $category in
                            CategoryCard(category: $category)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(12)
            }

            Divider()

            // Footer
            HStack {
                Text("\(state.selectedCount)/\(state.totalCount) seleccionados")
                    .foregroundColor(.secondary)
                    .font(.system(size: 11))

                Spacer()

                Button("Cancelar") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut(.cancelAction)
                .controlSize(.regular)

                Button("Instalar") {
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
        .frame(width: 900, height: 700)
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
        .windowResizability(.contentSize)
    }
}
