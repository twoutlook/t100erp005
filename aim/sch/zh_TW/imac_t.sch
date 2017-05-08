/* 
================================================================================
檔案代號:imac_t
檔案名稱:料件資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imac_t
(
imacent       number(5)      ,/* 企業編號 */
imac001       varchar2(40)      ,/* 料件編號 */
imac002       varchar2(1)      ,/* BOM異動否 */
imac003       number(5,0)      ,/* 低階碼 */
imacownid       varchar2(20)      ,/* 資料所有者 */
imacowndp       varchar2(10)      ,/* 資料所有部門 */
imaccrtid       varchar2(20)      ,/* 資料建立者 */
imaccrtdt       timestamp(0)      ,/* 資料創建日 */
imaccrtdp       varchar2(10)      ,/* 資料建立部門 */
imacmodid       varchar2(20)      ,/* 資料修改者 */
imacmoddt       timestamp(0)      ,/* 最近修改日 */
imaccnfid       varchar2(20)      ,/* 資料確認者 */
imaccnfdt       timestamp(0)      ,/* 資料確認日 */
imacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imac_t add constraint imac_pk primary key (imacent,imac001) enable validate;

create unique index imac_pk on imac_t (imacent,imac001);

grant select on imac_t to tiptop;
grant update on imac_t to tiptop;
grant delete on imac_t to tiptop;
grant insert on imac_t to tiptop;

exit;
