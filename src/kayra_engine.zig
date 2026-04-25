const std = @import("std");

/// ==============================================================================
/// KAYRA KERNEL ENGINE (v1.0.0)
/// Alperen Yapisal Disiplin ve Ihlasi Koruma Yazilimi
/// Dil: Zig (Robust, Optimal, Low-Level Control)
/// ==============================================================================

pub const NefsLevel = enum {
    Emmare,     // Kötülüğü emreden
    Levvame,    // Kendini kinayan
    Mulhime,    // Ilham alan
    Mutmainne,  // Tatmin olmus, huzurlu
    Radiye,     // Razi olmus
    Mardiyye,   // Kendisinden razi olunmus
    Safiye      // Saf ve temiz
};

pub const KayraEngine = struct {
    allocator: std.mem.Allocator,
    nofap_streak: u32,
    teheccud_active: bool,
    dopamine_level: f32, // target is low
    nefs_state: NefsLevel,
    is_kavvam: bool,
    
    pub fn init(allocator: std.mem.Allocator) KayraEngine {
        return KayraEngine{
            .allocator = allocator,
            .nofap_streak = 0,
            .teheccud_active = false,
            .dopamine_level = 99.9, // starts critically high due to Matrix conditioning
            .nefs_state = .Emmare,
            .is_kavvam = false,
        };
    }
    
    pub fn deploy_dopamine_detox(self: *KayraEngine) void {
        const reset_multiplier: f32 = 0.15;
        self.dopamine_level *= reset_multiplier; 
        if (self.dopamine_level < 50.0) {
            self.nefs_state = .Levvame;
        }
    }

    pub fn execute_morning_prayer(self: *KayraEngine) void {
        self.teheccud_active = true;
        self.dopamine_level -= 5.0; // Purity increase
        if (self.dopamine_level < 20.0) {
            self.nefs_state = .Mutmainne;
        }
    }
    
    pub fn assert_kavvam_leadership(self: *KayraEngine) void {
        self.is_kavvam = true;
    }

    pub fn diagnose_system(self: KayraEngine) !void {
        const stdout = std.io.getStdOut().writer();
        try stdout.print("\n------------------------------------------------\n", .{});
        try stdout.print("  [ KAYRA KERNEL DIAGNOSTICS ]\n", .{});
        try stdout.print("------------------------------------------------\n", .{});
        try stdout.print("Dopamin Kontaminasyonu : {d:.2}%\n", .{self.dopamine_level});
        try stdout.print("Sabah/Teheccud Tesis   : {}\n", .{self.teheccud_active});
        try stdout.print("Kavvam (Liderlik)      : {}\n", .{self.is_kavvam});
        try stdout.print("Nefs Mertebesi         : {s}\n", .{@tagName(self.nefs_state)});
        
        if (self.dopamine_level < 25.0 and self.teheccud_active and self.is_kavvam) {
            try stdout.print("\n[>>] SISTEM OPTIMUM: Fıtrat ayarlarına dönüldü. Nizam sağlandı.\n", .{});
        } else {
            try stdout.print("\n[!!] DIKKAT: Gaflet (Matrix) seviyesi kritik!\n", .{});
            try stdout.print("Acil arinma ve tevbe protokolunu aktif et.\n", .{});
        }
        try stdout.print("------------------------------------------------\n\n", .{});
    }
};

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    
    // Matrix tarzı terminal çıktısı simülasyonu
    try stdout.print("\n[ INIT ] KAYRA ZIG ENGINE YUKLENIYOR...\n", .{});
    try stdout.print("[ INIT ] Bellek ve Irade tahsis ediliyor...\n", .{});
    
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    
    var engine = KayraEngine.init(gpa.allocator());
    
    // Protokolleri uygula
    try stdout.print("[ EXEC ] Dopamin Detoksu Devrede.\n", .{});
    engine.deploy_dopamine_detox();
    
    try stdout.print("[ EXEC ] Sabah Inşasi (Teheccüd) Devrede.\n", .{});
    engine.execute_morning_prayer();
    
    try stdout.print("[ EXEC ] Kavvam Hiyerarsisi Onaylandi.\n", .{});
    engine.assert_kavvam_leadership();
    
    // Nihai Durum Raporu
    try engine.diagnose_system();
}
