const std = @import("std");

/// ==============================================================================
/// FUTUWWA NEURAL CORE - KAYRA SYSTEM v2.0
/// Alp (Celal) ve Eren (Cemal) dengesini simüle eden karar çekirdeği.
/// ==============================================================================

pub const FutuwwaNode = struct {
    weight: f32,
    bias: f32,
    is_active: bool,
};

pub const FutuwwaAI = struct {
    celal_bias: f32, // Savaşçı/Sertlik ekseni
    cemal_bias: f32, // Derviş/Merhamet ekseni
    patience: f32,
    
    pub fn init() FutuwwaAI {
        return FutuwwaAI{
            .celal_bias = 0.5,
            .cemal_bias = 0.5,
            .patience = 1.0,
        };
    }

    /// Sabır eğitimini simüle eder, Eren (Cemal) dengesini artırır.
    pub fn train_patience(self: *FutuwwaAI) void {
        self.patience += 0.1;
        self.cemal_bias += 0.05;
        self.celal_bias -= 0.02;
    }
    
    /// Hiddet ve kinetiği simüle eder, Alp (Celal) dengesini artırır.
    pub fn train_intensity(self: *FutuwwaAI) void {
        self.celal_bias += 0.1;
        self.cemal_bias -= 0.05;
        self.patience -= 0.02;
    }

    /// Gelen bir duruma karşı Alperen tepkisini hesaplar.
    pub fn evaluate_scenario(self: *FutuwwaAI, threat_level: f32) []const u8 {
        const response_intensity = (threat_level * self.celal_bias) - (self.patience * self.cemal_bias);
        
        if (response_intensity > 0.8) {
            return "ZÜLFİKAR ÇEKİLDİ: Mutlak Celal ile müdahale ediliyor.";
        } else if (response_intensity > 0.4) {
            return "KAVVAMİYET: Düzen ve otorite tesis ediliyor.";
        } else if (response_intensity > -0.2) {
            return "İSTİKAMET: Sabır ve vakar ile yol alınıyor.";
        } else {
            return "SIRR-I İHLAS: Derin tefekkür ve Cemal tecellisi.";
        }
    }
};
