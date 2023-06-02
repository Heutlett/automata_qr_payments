using System;
using System.Collections.Generic;

namespace Api.Scaffold;

public partial class Usuario
{
    public int Id { get; set; }

    public string Uid { get; set; } = null!;

    public string Username { get; set; } = null!;

    public byte[] PasswordHash { get; set; } = null!;

    public byte[] PasswordSalt { get; set; } = null!;

    public string Email { get; set; } = null!;

    public bool Rol { get; set; }

    public virtual ICollection<Cuenta> Cuenta { get; } = new List<Cuenta>();
}
