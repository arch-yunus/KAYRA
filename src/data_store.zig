const std = @import("std");

/// KAYRA Protokol Veri Tabani
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
        self.records.deinit();
    }

    pub fn insert(self: *MemoryStore, key: []const u8, val: []const u8) !void {
        try self.records.put(key, val);
    }
    
    pub fn retrieve(self: *MemoryStore, key: []const u8) ?[]const u8 {
        return self.records.get(key);
    }
};

pub fn perform_heavy_sort(data: []u32) void {
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
const std = @import("std");

/// KAYRA Protokol Veri Tabani
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
        self.records.deinit();
    }

    pub fn insert(self: *MemoryStore, key: []const u8, val: []const u8) !void {
        try self.records.put(key, val);
    }
    
    pub fn retrieve(self: *MemoryStore, key: []const u8) ?[]const u8 {
        return self.records.get(key);
    }
};

pub fn perform_heavy_sort(data: []u32) void {
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
const std = @import("std");

/// KAYRA Protokol Veri Tabani
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
        self.records.deinit();
    }

    pub fn insert(self: *MemoryStore, key: []const u8, val: []const u8) !void {
        try self.records.put(key, val);
    }
    
    pub fn retrieve(self: *MemoryStore, key: []const u8) ?[]const u8 {
        return self.records.get(key);
    }
};

pub fn perform_heavy_sort(data: []u32) void {
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
const std = @import("std");

/// KAYRA Protokol Veri Tabani
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
        self.records.deinit();
    }

    pub fn insert(self: *MemoryStore, key: []const u8, val: []const u8) !void {
        try self.records.put(key, val);
    }
    
    pub fn retrieve(self: *MemoryStore, key: []const u8) ?[]const u8 {
        return self.records.get(key);
    }
};

pub fn perform_heavy_sort(data: []u32) void {
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
const std = @import("std");

/// KAYRA Protokol Veri Tabani
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
        self.records.deinit();
    }

    pub fn insert(self: *MemoryStore, key: []const u8, val: []const u8) !void {
        try self.records.put(key, val);
    }
    
    pub fn retrieve(self: *MemoryStore, key: []const u8) ?[]const u8 {
        return self.records.get(key);
    }
};

pub fn perform_heavy_sort(data: []u32) void {
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
