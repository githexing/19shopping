using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace lgk.Model
{
    /// <summary>
	/// tb_FhDian:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
    public partial class tb_FhDian
    {
        public tb_FhDian()
        { }
        #region Model
        private long _id;
        private long _userid = 0;
        private string _ordercode;
        private decimal _amount = 0M;
        private decimal _topmoney = 0M;
        private decimal _surplusmoney = 0M;
        private DateTime? _addtime;
        private int _isout = 0;
        private int _isbatch = 0;
        /// <summary>
        /// 
        /// </summary>
        public long ID
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public long UserID
        {
            set { _userid = value; }
            get { return _userid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string OrderCode
        {
            set { _ordercode = value; }
            get { return _ordercode; }
        }
        /// <summary>
        /// 
        /// </summary>
        public decimal Amount
        {
            set { _amount = value; }
            get { return _amount; }
        }
        /// <summary>
        /// 
        /// </summary>
        public decimal TopMoney
        {
            set { _topmoney = value; }
            get { return _topmoney; }
        }
        /// <summary>
        /// 
        /// </summary>
        public decimal SurplusMoney
        {
            set { _surplusmoney = value; }
            get { return _surplusmoney; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? AddTime
        {
            set { _addtime = value; }
            get { return _addtime; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int IsOut
        {
            set { _isout = value; }
            get { return _isout; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int IsBatch
        {
            set { _isbatch = value; }
            get { return _isbatch; }
        }
        #endregion Model

    }
}
