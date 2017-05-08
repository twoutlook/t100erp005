/* 
================================================================================
檔案代號:dbbd_t
檔案名稱:庫存組織出貨範圍設定-產品範圍
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table dbbd_t
(
dbbdent       number(5)      ,/* 企業編號 */
dbbdsite       varchar2(10)      ,/* 營運據點 */
dbbd001       varchar2(10)      ,/* 庫位編號 */
dbbd002       varchar2(10)      ,/* 產品屬性類型 */
dbbd003       varchar2(40)      ,/* 屬性值編號 */
dbbdownid       varchar2(20)      ,/* 資料所有者 */
dbbdowndp       varchar2(10)      ,/* 資料所屬部門 */
dbbdcrtid       varchar2(20)      ,/* 資料建立者 */
dbbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbbdcrtdt       timestamp(0)      ,/* 資料創建日 */
dbbdmodid       varchar2(20)      ,/* 資料修改者 */
dbbdmoddt       timestamp(0)      ,/* 最近修改日 */
dbbdstus       varchar2(10)      ,/* 狀態碼 */
dbbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbbd_t add constraint dbbd_pk primary key (dbbdent,dbbdsite,dbbd001,dbbd002,dbbd003) enable validate;

create unique index dbbd_pk on dbbd_t (dbbdent,dbbdsite,dbbd001,dbbd002,dbbd003);

grant select on dbbd_t to tiptop;
grant update on dbbd_t to tiptop;
grant delete on dbbd_t to tiptop;
grant insert on dbbd_t to tiptop;

exit;
