/* 
================================================================================
檔案代號:gldr_t
檔案名稱:合併報表長期投資成本法轉權益法維護單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gldr_t
(
gldrent       number(5)      ,/* 企業編號 */
gldrld       varchar2(5)      ,/* 合併帳套 */
gldr001       varchar2(10)      ,/* 投資公司 */
gldr002       number(5,0)      ,/* 年度 */
gldr003       number(5,0)      ,/* 期別 */
gldr004       varchar2(10)      ,/* 被投資公司 */
gldr005       varchar2(5)      ,/* 個體帳套 */
gldr006       varchar2(24)      ,/* 長期股權投資科目編號 */
gldr008       number(20,6)      ,/* 借方金額(記帳幣) */
gldr009       number(20,6)      ,/* 貸方金額(記帳幣) */
gldr010       number(20,6)      ,/* 借方金額(功能幣) */
gldr011       number(20,6)      ,/* 貸方金額(功能幣) */
gldr012       number(20,6)      ,/* 借方金額(報告幣) */
gldr013       number(20,6)      ,/* 貸方金額(報告幣) */
gldrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldr_t add constraint gldr_pk primary key (gldrent,gldrld,gldr001,gldr002,gldr003,gldr004,gldr006) enable validate;

create unique index gldr_pk on gldr_t (gldrent,gldrld,gldr001,gldr002,gldr003,gldr004,gldr006);

grant select on gldr_t to tiptop;
grant update on gldr_t to tiptop;
grant delete on gldr_t to tiptop;
grant insert on gldr_t to tiptop;

exit;
