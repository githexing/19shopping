using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Library
{
    /// <summary>
    /// 币种类别
    /// </summary>
    public enum AccountType
    {
        注册分 = 1,
        奖励分 = 2,
        复利分 = 3,
        激活分 = 4,
        购物分 = 5
    };

}

namespace Library
{
    public class AccountTypeHelper
    {
        public static string GetName(int type)
        {
            return Enum.GetName(typeof(AccountType), type);
        }
    }
}


