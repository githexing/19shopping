﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace lgk.BLL
{
    public class tb_TrainTicketsOrder
    {
        private readonly lgk.DAL.tb_TrainTicketsOrder dal = new lgk.DAL.tb_TrainTicketsOrder();
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int ID)
        {
            return dal.Exists(ID);
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(lgk.Model.tb_TrainTicketsOrder model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(lgk.Model.tb_TrainTicketsOrder model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int ID)
        {

            return dal.Delete(ID);
        }
        public lgk.Model.tb_TrainTicketsOrder GetModel(string where)
        {
            return dal.GetModel(where);
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
    }
}
