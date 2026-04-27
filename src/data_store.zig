const std = @import("std");

/// ==============================================================================
/// DATA STORE - KAYRA SYSTEM v2.0
/// İrade ve Lojistik kayıtlarını tutan bellek içi veri deposu.
/// ==============================================================================

pub const MemoryStore = struct {
    allocator: std.mem.Allocator,
    records: std.StringHashMap([]const u8),

    pub fn init(allocator: std.mem.Allocator) !MemoryStore {
        return MemoryStore{
            .allocator = allocator,
            .records = std.StringHashMap([]const u8).init(allocator),
        };
    }

    pub fn deinit(self: *MemoryStore) void {
        var it = self.records.iterator();
        while (it.next()) |entry| {
            self.allocator.free(entry.value_ptr.*);
        }
        self.records.deinit();
    }

    pub fn insert(self: *MemoryStore, key: []const u8, val: []const u8) !void {
        const val_copy = try self.allocator.dupe(u8, val);
        try self.records.put(key, val_copy);
    }
    
    pub fn retrieve(self: *MemoryStore, key: []const u8) ?[]const u8 {
        return self.records.get(key);
    }
};

/// 'Ahi Sandığı' için lojistik sıralama (Basit Bubble Sort simülasyonu)
pub fn sort_logistics(data: []u32) void {
    var i: usize = 0;
    while (i < data.len) : (i += 1) {
        var j: usize = 0;
        while (j < data.len - 1) : (j += 1) {
            if (data[j] > data[j+1]) {
                const temp = data[j];
                data[j] = data[j+1];
                data[j+1] = temp;
            }
        }
    }
}
