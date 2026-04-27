const std = @import("std");
const FutuwwaAI = @import("futuwwa_neural.zig").FutuwwaAI;
const ZihinselKalkan = @import("crypto_shield.zig").ZihinselKalkan;
const AsabiyyahNet = @import("asabiyyah_net.zig").AsabiyyahNet;

/// ==============================================================================
/// SCENARIOS - ARŞ-I NİZAM
/// Alperen disiplinini test eden operasyonel senaryolar.
/// ==============================================================================

pub const ScenarioRunner = struct {
    allocator: std.mem.Allocator,

    pub fn run_social_collapse(self: *ScenarioRunner) !void {
        var net = AsabiyyahNet.init(self.allocator);
        defer net.deinit();

        std.debug.print("\n[SENARYO: SOSYAL ÇÖKÜŞ VE ASABİYET TESTİ]\n", .{});
        try net.add_node(.Nakip, 0.95);
        try net.add_node(.İhvan, 0.80);
        try net.add_node(.İhvan, 0.70);
        
        std.debug.print("Ağ Durumu: {s}\n", .{net.get_status()});
        std.debug.print("Toplam Asabiyet: {d:.2}\n", .{net.total_asabiyyah});
    }

    pub fn run_mental_siege(self: *ScenarioRunner) !void {
        var kalkan = ZihinselKalkan{ .integrity = 0.85, .vesvese_filter_on = true };
        std.debug.print("\n[SENARYO: ZİHİNSEL KUŞATMA VE MANİPÜLASYON SIZMASI]\n", .{});
        
        const threats = [_][]const u8{ "Ümitsizlik pakedi", "Narsizm güncellemesi", "Tüketim arzusu virüsü" };
        for (threats) |threat| {
            kalkan.block_matrix_intrusion(threat);
        }
    }
};
