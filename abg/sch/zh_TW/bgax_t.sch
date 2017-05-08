/* 
================================================================================
檔案代號:bgax_t
檔案名稱:预算目标档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgax_t
(
bgaxent       number(5)      ,/* 企业编号 */
bgax001       varchar2(10)      ,/* 预算编号 */
bgax002       varchar2(10)      ,/* 预算版本 */
bgax003       varchar2(10)      ,/* 预算组织 */
bgax004       number(10,0)      ,/* 项次 */
bgax005       varchar2(24)      ,/* 预算细项 */
bgax006       varchar2(1)      ,/* 数据源 */
bgax007       varchar2(10)      ,/* 计量单位 */
bgax008       number(20,6)      ,/* 前二期实际 */
bgax009       number(20,6)      ,/* 前一期实际 */
bgax010       number(20,6)      ,/* 当前期实际 */
bgax011       number(20,6)      ,/* 三期平均值 */
bgax012       number(20,6)      ,/* 三期增长率% */
bgax013       number(20,6)      ,/* 预算目标值（最低） */
bgax014       number(20,10)      ,/* 预算挑战值（最高） */
bgax015       number(5,0)      ,/* 期别 */
bgax016       varchar2(10)      ,/* 部门 */
bgax017       varchar2(10)      ,/* 利润中心 */
bgax018       varchar2(10)      ,/* 区域 */
bgax019       varchar2(10)      ,/* 交易客商 */
bgax020       varchar2(10)      ,/* 收款客商 */
bgax021       varchar2(10)      ,/* 客群 */
bgax022       varchar2(10)      ,/* 产品类别 */
bgax023       varchar2(20)      ,/* 人员 */
bgax024       varchar2(20)      ,/* 项目编号 */
bgax025       varchar2(30)      ,/* WBS */
bgax026       varchar2(10)      ,/* 经营方式 */
bgax027       varchar2(30)      ,/* 自由核算项一 */
bgax028       varchar2(30)      ,/* 自由核算项二 */
bgax029       varchar2(30)      ,/* 自由核算项三 */
bgax030       varchar2(30)      ,/* 自由核算项四 */
bgax031       varchar2(30)      ,/* 自由核算项五 */
bgax032       varchar2(30)      ,/* 自由核算项六 */
bgax033       varchar2(30)      ,/* 自由核算项七 */
bgax034       varchar2(30)      ,/* 自由核算项八 */
bgax035       varchar2(30)      ,/* 自由核算项九 */
bgax036       varchar2(30)      ,/* 自由核算项十 */
bgaxownid       varchar2(20)      ,/* 资料所有者 */
bgaxowndp       varchar2(10)      ,/* 资料所有部门 */
bgaxcrtid       varchar2(20)      ,/* 资料录入者 */
bgaxcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgaxcrtdt       timestamp(0)      ,/* 资料创建日 */
bgaxmodid       varchar2(20)      ,/* 资料更改者 */
bgaxmoddt       timestamp(0)      ,/* 最近更改日 */
bgaxstus       varchar2(10)      ,/* 状态码 */
bgaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgax_t add constraint bgax_pk primary key (bgaxent,bgax001,bgax002,bgax003,bgax004) enable validate;

create unique index bgax_pk on bgax_t (bgaxent,bgax001,bgax002,bgax003,bgax004);

grant select on bgax_t to tiptop;
grant update on bgax_t to tiptop;
grant delete on bgax_t to tiptop;
grant insert on bgax_t to tiptop;

exit;
