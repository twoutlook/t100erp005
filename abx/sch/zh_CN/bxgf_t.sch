/* 
================================================================================
檔案代號:bxgf_t
檔案名稱:年度保稅原料結算資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxgf_t
(
bxgfent       number(5)      ,/* 企業編號 */
bxgfsite       varchar2(10)      ,/* 營運據點 */
bxgf001       number(5,0)      ,/* 年度 */
bxgf002       varchar2(40)      ,/* 料件編號 */
bxgf003       number(20,6)      ,/* 期初保稅結存數量 */
bxgf004       number(20,6)      ,/* 期初非保稅結存數量 */
bxgf005       number(20,6)      ,/* 本期保稅進貨數量 */
bxgf006       number(20,6)      ,/* 本期非保稅進貨數量 */
bxgf007       number(20,6)      ,/* 本期外銷使用數量 */
bxgf008       number(20,6)      ,/* 本期內銷使用數量 */
bxgf009       number(20,6)      ,/* 本期外運數量 */
bxgf010       number(20,6)      ,/* 本期報廢數量 */
bxgf011       number(20,6)      ,/* 本期盤存數量 */
bxgf012       number(20,6)      ,/* 本期盤盈虧數量 */
bxgf013       number(20,6)      ,/* 盤差容許數量 */
bxgf014       number(20,6)      ,/* 本期盤差補稅數量 */
bxgf015       number(20,6)      ,/* 期末應結轉下期保稅數量 */
bxgf016       number(20,6)      ,/* 期末應結轉下期非保稅數量 */
bxgfownid       varchar2(20)      ,/* 資料所有者 */
bxgfowndp       varchar2(10)      ,/* 資料所屬部門 */
bxgfcrtid       varchar2(20)      ,/* 資料建立者 */
bxgfcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxgfcrtdt       timestamp(0)      ,/* 資料創建日 */
bxgfmodid       varchar2(20)      ,/* 資料修改者 */
bxgfmoddt       timestamp(0)      ,/* 最近修改日 */
bxgfcnfid       varchar2(20)      ,/* 資料確認者 */
bxgfcnfdt       timestamp(0)      ,/* 資料確認日 */
bxgfstus       varchar2(10)      ,/* 狀態碼 */
bxgfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxgfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxgfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxgfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxgfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxgfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxgfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxgfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxgfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxgfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxgfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxgfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxgfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxgfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxgfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxgfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxgfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxgfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxgfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxgfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxgfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxgfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxgfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxgfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxgfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxgfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxgfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxgfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxgfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxgfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxgf_t add constraint bxgf_pk primary key (bxgfent,bxgfsite,bxgf001,bxgf002) enable validate;

create unique index bxgf_pk on bxgf_t (bxgfent,bxgfsite,bxgf001,bxgf002);

grant select on bxgf_t to tiptop;
grant update on bxgf_t to tiptop;
grant delete on bxgf_t to tiptop;
grant insert on bxgf_t to tiptop;

exit;
