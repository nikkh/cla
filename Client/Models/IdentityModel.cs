using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace TodoListClient.Models
{
    public class IdentityModel
    {
        public IdentityModel() 
        { 
            Data = new Dictionary<string, string>() ;
        }
        public string Test1 { get; set; }
        public string Blah { get; set; }

        public Dictionary<string, string> Data { get;  }

    }
}
