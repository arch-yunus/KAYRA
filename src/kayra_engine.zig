const std = @import("std");
const crypto = @import("crypto_shield.zig");
const neural = @import("futuwwa_neural.zig");
const db = @import("data_store.zig");

/// ==============================================================================
/// KAYRA KERNEL ENGINE (v2.0 - Alperen Architecture)
/// Alperen Yapısal Disiplin ve İhlası Koruma Yazılımı Çekirdeği.
/// ==============================================================================

pub const NefsLevel = enum {
    Emmare, Levvame, Mulhime, Mutmainne, Radiye, Mardiyye, Safiye
};

pub const KayraEngine = struct {
    allocator: std.mem.Allocator,
    stdout: std.fs.File.Writer,
    dopamine_level: f32,
    nefs_state: NefsLevel,
    is_kavvam: bool,
    database: db.MemoryStore,
    shield: crypto.ZihinselKalkan,
    ai_core: neural.FutuwwaAI,

    pub fn init(allocator: std.mem.Allocator, writer: std.fs.File.Writer) !KayraEngine {
        return KayraEngine{
            .allocator = allocator,
            .stdout = writer,
            .dopamine_level = 90.0,
            .nefs_state = .Emmare,
            .is_kavvam = false,
            .database = try db.MemoryStore.init(allocator),
            .shield = crypto.ZihinselKalkan.init(writer),
            .ai_core = neural.FutuwwaAI.init(),
        };
    }

    pub fn deinit(self: *KayraEngine) void {
        self.database.deinit();
    }

    /// 04:00 - 05:30 | İLAHİ NÖBET (Teheccüd Dirilişi)
    pub fn execute_teheccud(self: *KayraEngine) void {
        self.stdout.print("\n[ PHASE ] 04:00 - Teheccüd Dirilişi Başlatıldı.\n", .{}) catch {};
        self.dopamine_level -= 10.0;
        self.nefs_state = .Levvame;
        self.shield.activate();
        self.ai_core.train_patience();
        self.stdout.print("[ STAT ] İrade tahkim edildi. Nefs: {s}\n", .{@tagName(self.nefs_state)}) catch {};
    }
    
    /// 05:30 - 07:30 | İLMİ KILIÇLANMA
    pub fn execute_ilmi_kiliclanma(self: *KayraEngine) !void {
        self.stdout.print("\n[ PHASE ] 05:30 - İlmi Kılıçlanma (Zihni Silahlandırma).\n", .{}) catch {};
        try self.database.insert("subject_1", "Risale-i Nur Tahlilleri");
        try self.database.insert("subject_2", "Modern Sistem Analizi");
        self.stdout.print("[ STAT ] Bellek (RAM) hakikat ile dolduruldu.\n", .{}) catch {};
    }

    /// 08:00 - 18:00 | RIZIK CEPHESİ (Kavvamlık)
    pub fn execute_rizik_cephesi(self: *KayraEngine) void {
        self.stdout.print("\n[ PHASE ] 08:00 - Rızık Cephesi (Kavvamlık Misyonu).\n", .{}) catch {};
        self.is_kavvam = true;
        self.ai_core.train_intensity();
        const decision = self.ai_core.evaluate_scenario(0.75);
        self.stdout.print("[ STAT ] Cephe Kararı: {s}\n", .{decision}) catch {};
    }

    /// MATRIX Savunması Simülasyonu
    pub fn run_defense_simulation(self: *KayraEngine) void {
        self.stdout.print("\n[ SIM ] Matrix Sızma Testi Başlatılıyor...\n", .{}) catch {};
        _ = self.shield.block_matrix_intrusion("Sosyal Medya Dopamin Tuzağı");
        _ = self.shield.block_matrix_intrusion("Gaflet Vesvesesi");
        _ = self.shield.block_matrix_intrusion("Seküler Konfor Arzusu");
    }
};

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("\n", .{});
    try stdout.print("  ██╗  ██╗ █████╗ ██╗   ██╗██████╗  █████╗ \n", .{});
    try stdout.print("  ██║ ██╔╝██╔══██╗╚██╗ ██╔╝██╔══██╗██╔══██╗\n", .{});
    try stdout.print("  █████╔╝ ███████║ ╚████╔╝ ██████╔╝███████║\n", .{});
    try stdout.print("  ██╔═██╗ ██╔══██║  ╚██╔╝  ██╔══██╗██╔══██║\n", .{});
    try stdout.print("  ██║  ██╗██║  ██║   ██║   ██║  ██║██║  ██║\n", .{});
    try stdout.print("  ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝\n", .{});
    try stdout.print("\n[ INIT ] KAYRA KERNEL V2.0 - ALPEREN EDITION\n", .{});
    
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    
    var engine = try KayraEngine.init(gpa.allocator(), stdout);
    defer engine.deinit();

    engine.execute_teheccud();
    try engine.execute_ilmi_kiliclanma();
    engine.execute_rizik_cephesi();
    engine.run_defense_simulation();

    try stdout.print("\n==================================================\n", .{});
    try stdout.print(" SISTEM ON-LINE. NİZAM-I ALEM İÇİN HAZIR.\n", .{});
    try stdout.print("==================================================\n\n", .{});
}
