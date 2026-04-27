const std = @import("std");
const ZihinselKalkan = @import("crypto_shield.zig").ZihinselKalkan;
const FutuwwaAI = @import("futuwwa_neural.zig").FutuwwaAI;
const AsabiyyahNet = @import("asabiyyah_net.zig").AsabiyyahNet;
const ScenarioRunner = @import("scenarios.zig").ScenarioRunner;

/// ==============================================================================
/// KAYRA ENGINE v3.0 - ARŞ-I NİZAM (Supreme Order)
/// Alperen Karargah Çekirdeği - Full Operational Suite.
/// ==============================================================================

pub const KayraEngine = struct {
    allocator: std.mem.Allocator,
    stdout: std.fs.File.Writer,
    dopamine_level: f32,
    nefs_level: f32,
    kalkan: ZihinselKalkan,
    futuwwa: FutuwwaAI,
    asabiyet: AsabiyyahNet,

    pub fn init(allocator: std.mem.Allocator, writer: std.fs.File.Writer) !KayraEngine {
        return KayraEngine{
            .allocator = allocator,
            .stdout = writer,
            .dopamine_level = 0.5,
            .nefs_level = 0.8,
            .kalkan = ZihinselKalkan{ .integrity = 0.9, .vesvese_filter_on = true },
            .futuwwa = FutuwwaAI.init(allocator),
            .asabiyet = AsabiyyahNet.init(allocator),
        };
    }

    pub fn deinit(self: *KayraEngine) void {
        self.asabiyet.deinit();
    }

    pub fn log_operation(self: *KayraEngine, phase: []const u8, message: []const u8) void {
        self.stdout.print("[KAYRA.OS][{s}] {s}\n", .{ phase, message }) catch {};
    }

    pub fn run_daily_cycle(self: *KayraEngine) !void {
        self.log_operation("START", "Sistem Arş-ı Nizam fazında başlatıldı.");
        
        // 04:00 - Teheccüd
        self.log_operation("CYCLE", "Faz 01: Teheccüd Dirilişi. Ene imha ediliyor.");
        self.nefs_level -= 0.2;
        
        // 05:30 - İlim
        self.log_operation("CYCLE", "Faz 02: İlmi Kılıçlanma. Zihin kalkanı tahkim ediliyor.");
        self.kalkan.block_matrix_intrusion("Modern Gaflet");

        // 08:00 - Rızık
        self.log_operation("CYCLE", "Faz 03: Rızık Cephesi. Lojistik veri akışı stabil.");
        
        // Tactical Scenarios
        var runner = ScenarioRunner{ .allocator = self.allocator };
        try runner.run_mental_siege();
        try runner.run_social_collapse();

        self.log_operation("END", "Günlük döngü tamamlandı. İhlâs seviyesi: ARŞ-I NİZAM.");
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const stdout = std.io.getStdOut().writer();
    
    try stdout.print("\n", .{});
    try stdout.print("  ██╗  ██╗ █████╗ ██╗   ██╗██████╗  █████╗ \n", .{});
    try stdout.print("  ██║ ██╔╝██╔══██╗╚██╗ ██╔╝██╔══██╗██╔══██╗\n", .{});
    try stdout.print("  █████╔╝ ███████║ ╚████╔╝ ██████╔╝███████║\n", .{});
    try stdout.print("  ██╔═██╗ ██╔══██║  ╚██╔╝  ██╔══██╗██╔══██║\n", .{});
    try stdout.print("  ██║  ██╗██║  ██║   ██║   ██║  ██║██║  ██║\n", .{});
    try stdout.print("  ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝\n", .{});

    var engine = try KayraEngine.init(allocator, stdout);
    defer engine.deinit();

    try engine.run_daily_cycle();
}
