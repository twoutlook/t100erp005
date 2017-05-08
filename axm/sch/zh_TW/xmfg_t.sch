/* 
================================================================================
檔案代號:xmfg_t
檔案名稱:销售报价单身分量计价档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfg_t
(
xmfgent       number(5)      ,/* 企业编号 */
xmfgsite       varchar2(10)      ,/* 营运据点 */
xmfgdocno       varchar2(20)      ,/* 报价单号 */
xmfgseq       number(10,0)      ,/* 项次 */
xmfg001       number(20,6)      ,/* 起始数量 */
xmfg002       number(20,6)      ,/* 截止数量 */
xmfg003       number(20,6)      ,/* 单价 */
xmfg004       number(20,6)      ,/* 折扣率 */
xmfgud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
xmfgud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
xmfgud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
xmfgud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
xmfgud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
xmfgud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
xmfgud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
xmfgud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
xmfgud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
xmfgud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
xmfgud011       number(20,6)      ,/* 自定义栏位(数字)011 */
xmfgud012       number(20,6)      ,/* 自定义栏位(数字)012 */
xmfgud013       number(20,6)      ,/* 自定义栏位(数字)013 */
xmfgud014       number(20,6)      ,/* 自定义栏位(数字)014 */
xmfgud015       number(20,6)      ,/* 自定义栏位(数字)015 */
xmfgud016       number(20,6)      ,/* 自定义栏位(数字)016 */
xmfgud017       number(20,6)      ,/* 自定义栏位(数字)017 */
xmfgud018       number(20,6)      ,/* 自定义栏位(数字)018 */
xmfgud019       number(20,6)      ,/* 自定义栏位(数字)019 */
xmfgud020       number(20,6)      ,/* 自定义栏位(数字)020 */
xmfgud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
xmfgud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
xmfgud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
xmfgud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
xmfgud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
xmfgud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
xmfgud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
xmfgud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
xmfgud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
xmfgud030       timestamp(0)      ,/* 自定义栏位(日期时间)030 */
xmfg005       varchar2(255)      /* 备注 */
);
alter table xmfg_t add constraint xmfg_pk primary key (xmfgent,xmfgdocno,xmfgseq,xmfg001,xmfg002) enable validate;

create unique index xmfg_pk on xmfg_t (xmfgent,xmfgdocno,xmfgseq,xmfg001,xmfg002);

grant select on xmfg_t to tiptop;
grant update on xmfg_t to tiptop;
grant delete on xmfg_t to tiptop;
grant insert on xmfg_t to tiptop;

exit;
