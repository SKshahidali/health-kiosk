// symptom_mapping.dart

// Symptom to Department and Doctor mapping with multiple doctors per department
const Map<String, Map<String, dynamic>> symptomMapping = {
  "fever": {
    "department": "General Medicine",
    "doctors": ["Dr. Smith", "Dr. John"],
  },
  "cough": {
    "department": "Pulmonology",
    "doctors": ["Dr. Lung", "Dr. Breath"],
  },
  "headache": {
    "department": "Neurology",
    "doctors": ["Dr. Brain", "Dr. Nerve"],
  },
  "chest pain": {
    "department": "Cardiology",
    "doctors": ["Dr. Heartwell", "Dr. Beat"],
  },
  "stomach pain": {
    "department": "Gastroenterology",
    "doctors": ["Dr. Digest", "Dr. Stomach"],
  },
  "skin rash": {
    "department": "Dermatology",
    "doctors": ["Dr. Skin", "Dr. Glow"],
  },
  "joint pain": {
    "department": "Rheumatology",
    "doctors": ["Dr. Joint", "Dr. Flex"],
  },
  "anxiety": {
    "department": "Psychiatry",
    "doctors": ["Dr. Mind", "Dr. Care"],
  },
  "back pain": {
    "department": "Orthopedics",
    "doctors": ["Dr. Bone", "Dr. Joint"],
  },
  // Add more symptoms and mappings as needed
};
