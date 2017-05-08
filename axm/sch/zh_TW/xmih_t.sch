/* 
================================================================================
檔案代號:xmih_t
檔案名稱:集團銷售預測匯總單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmih_t
(
xmihent       number(5)      ,/* 企業編號 */
xmih001       varchar2(10)      ,/* 預測編號 */
xmih002       date      ,/* 預測起始日 */
xmih003       number(5,0)      ,/* 版本 */
xmih004       varchar2(10)      ,/* 本層組織 */
xmih005       varchar2(10)      ,/* 上層組織 */
xmihownid       varchar2(20)      ,/* 資料所有者 */
xmihowndp       varchar2(10)      ,/* 資料所屬部門 */
xmihcrtid       varchar2(20)      ,/* 資料建立者 */
xmihcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmihcrtdt       timestamp(0)      ,/* 資料創建日 */
xmihmodid       varchar2(20)      ,/* 資料修改者 */
xmihmoddt       timestamp(0)      ,/* 最近修改日 */
xmihcnfid       varchar2(20)      ,/* 資料確認者 */
xmihcnfdt       timestamp(0)      ,/* 資料確認日 */
xmihstus       varchar2(10)      ,/* 狀態碼 */
xmihud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmihud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmihud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmihud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmihud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmihud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmihud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmihud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmihud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmihud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmihud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmihud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmihud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmihud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmihud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmihud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmihud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmihud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmihud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmihud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmihud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmihud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmihud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmihud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmihud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmihud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmihud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmihud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmihud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmihud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmih_t add constraint xmih_pk primary key (xmihent,xmih001,xmih002,xmih003,xmih004) enable validate;

create unique index xmih_pk on xmih_t (xmihent,xmih001,xmih002,xmih003,xmih004);

grant select on xmih_t to tiptop;
grant update on xmih_t to tiptop;
grant delete on xmih_t to tiptop;
grant insert on xmih_t to tiptop;

exit;
