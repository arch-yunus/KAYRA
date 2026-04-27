const std = @import("std");

/// ==============================================================================
/// ASABIYYAH NETWORK CORE - KAYRA SYSTEM v2.0
/// İhvan (Kardeşlik) ağını ve Siber-Asabiyet düğümlerini simüle eden çekirdek.
/// ==============================================================================

pub const NodeLevel = enum {
    Talip,    // Başlangıç seviyesi
    İhvan,    // Sadık kardeş
    Hadim,    // Hizmet ehli
    Nakip,    // Öncü/Lider
};

pub const AsabiyyahNode = struct {
    id: u32,
    trust_weight: f32, // Güven ağırlığı (0.0 - 1.0)
    level: NodeLevel,
    is_active: bool,
};

pub const AsabiyyahNet = struct {
    nodes: std.ArrayList(AsabiyyahNode),
    total_asabiyyah: f32,
    
    pub fn init(allocator: std.mem.Allocator) AsabiyyahNet {
        return AsabiyyahNet{
            .nodes = std.ArrayList(AsabiyyahNode).init(allocator),
            .total_asabiyyah = 0.0,
        };
    }

    pub fn deinit(self: *AsabiyyahNet) void {
        self.nodes.deinit();
    }

    /// Yeni bir ihvan düğümü ekler.
    pub fn add_node(self: *AsabiyyahNet, level: NodeLevel, weight: f32) !void {
        const node = AsabiyyahNode{
            .id = @intCast(self.nodes.items.len),
            .trust_weight = weight,
            .level = level,
            .is_active = true,
        };
        try self.nodes.append(node);
        self.calculate_total_asabiyyah();
    }

    /// Ağın toplam asabiyet (kenetlenme) gücünü hesaplar.
    fn calculate_total_asabiyyah(self: *AsabiyyahNet) void {
        var sum: f32 = 0.0;
        for (self.nodes.items) |node| {
            if (node.is_active) {
                const multiplier: f32 = switch (node.level) {
                    .Talip => 1.0,
                    .İhvan => 2.0,
                    .Hadim => 3.5,
                    .Nakip => 5.0,
                };
                sum += node.trust_weight * multiplier;
            }
        }
        self.total_asabiyyah = sum;
    }

    pub fn get_status(self: *AsabiyyahNet) []const u8 {
        if (self.total_asabiyyah > 20.0) {
            return "FETİH KADROSU: Ağ sarsılmaz bir kenetlenme içindedir.";
        } else if (self.total_asabiyyah > 10.0) {
            return "İHVANSAL NİZAM: Güvenli ve aktif bir hücre yapısı.";
        } else {
            return "HALVET: Ağ henüz çekirdek aşamasındadır.";
        }
    }
};
