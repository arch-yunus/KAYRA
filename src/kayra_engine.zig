const std = @import("std");
const crypto = @import("crypto_shield.zig");
const neural = @import("futuwwa_neural.zig");
const db = @import("data_store.zig");

/// ==============================================================================
/// KAYRA KERNEL ENGINE (v2.0 - Extended Architecture)
/// Alperen Yapisal Disiplin ve Ihlasi Koruma Yazilimi
/// ==============================================================================

pub const NefsLevel = enum {
    Emmare, Levvame, Mulhime, Mutmainne, Radiye, Mardiyye, Safiye
};

pub const KayraEngine = struct {
    allocator: std.mem.Allocator,
    dopamine_level: f32,
    teheccud_active: bool,
    nefs_state: NefsLevel,
    is_kavvam: bool,
    database: db.MemoryStore,
    shield: crypto.ZihinselKalkan,
    ai_core: neural.FutuwwaAI,

    pub fn init(allocator: std.mem.Allocator) !KayraEngine {
        return KayraEngine{
            .allocator = allocator,
            .dopamine_level = 99.9,
            .teheccud_active = false,
            .nefs_state = .Emmare,
            .is_kavvam = false,
            .database = try db.MemoryStore.init(allocator),
            .shield = crypto.ZihinselKalkan.init(),
            .ai_core = neural.FutuwwaAI.init(),
        };
    }

    pub fn deinit(self: *KayraEngine) void {
        self.database.deinit();
    }

    pub fn deploy_dopamine_detox(self: *KayraEngine) void {
        self.dopamine_level *= 0.15;
        if (self.dopamine_level < 50.0) self.nefs_state = .Levvame;
        self.shield.activate();
    }
    
    pub fn execute_morning_prayer(self: *KayraEngine) void {
        self.teheccud_active = true;
        self.dopamine_level -= 5.0;
        if (self.dopamine_level < 20.0) self.nefs_state = .Mutmainne;
        self.ai_core.train_patience();
    }
};

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("\n[ INIT ] KAYRA KERNEL V2 YUKLENIYOR...\n", .{});
    
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    
    var engine = try KayraEngine.init(gpa.allocator());
    defer engine.deinit();

    try stdout.print("[ EXEC ] Dopamin Detoksu Devrede.\n", .{});
    engine.deploy_dopamine_detox();
    
    try stdout.print("[ EXEC ] Sabah Inşasi (Teheccüd) Devrede.\n", .{});
    engine.execute_morning_prayer();
    
    try stdout.print("[ SYNC ] Kriptografik Kalkan Durumu Onaylaniyor.\n", .{});
    const hash_val = engine.shield.generate_hash("Alperen_Protocol");
    try stdout.print("         Hash Teyidi: {d}\n", .{hash_val});

    try stdout.print("==================================================\n", .{});
    try stdout.print(" SISTEM OPTIMUM. GITHUB DOMINASYONU SAGLANDI.\n", .{});
    try stdout.print("==================================================\n\n", .{});
}
