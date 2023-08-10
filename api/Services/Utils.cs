using System.Security.Cryptography;
using System.Text;

namespace Api.Utils
{
    public static class AESEncryptionHelper
    {
        // Método para encriptar un mensaje
        public static string Encrypt(string message, string key)
        {
            byte[] messageBytes = Encoding.UTF8.GetBytes(message);
            byte[] keyBytes = Encoding.UTF8.GetBytes(key.PadRight(32, '0').Substring(0, 32)); // Utiliza una key de 256 bits (32 bytes)

            Aes aes = Aes.Create();
            aes.Key = keyBytes;
            aes.IV = new byte[aes.BlockSize / 8];

            ICryptoTransform encrypter = aes.CreateEncryptor();

            byte[] encryptedBytes = encrypter.TransformFinalBlock(messageBytes, 0, messageBytes.Length);
            string encryptedMessage = Convert.ToBase64String(encryptedBytes);

            return encryptedMessage;
        }

        // Método para desencriptar un mensaje
        public static string Decrypt(string encryptedMessage, string key)
        {
            byte[] encryptedBytes = Convert.FromBase64String(encryptedMessage);
            byte[] keyBytes = Encoding.UTF8.GetBytes(key.PadRight(32, '0').Substring(0, 32)); // Utiliza una key de 256 bits (32 bytes)

            Aes aes = Aes.Create();
            aes.Key = keyBytes;
            aes.IV = new byte[aes.BlockSize / 8];

            ICryptoTransform decryptor = aes.CreateDecryptor();

            byte[] decryptedBytes = decryptor.TransformFinalBlock(encryptedBytes, 0, encryptedBytes.Length);
            string decryptedMessage = Encoding.UTF8.GetString(decryptedBytes);

            return decryptedMessage;
        }
    }
}
