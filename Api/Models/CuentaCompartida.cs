using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace Api.Models
{

    public class CuentaCompartida
    {
        [Key]
        public int Id { get; set; }

        public Cuenta? Cuenta { get; set; }

        public Usuario? Usuario { get; set; }
    }
}