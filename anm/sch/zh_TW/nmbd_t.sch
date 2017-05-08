/* 
================================================================================
檔案代號:nmbd_t
檔案名稱:資金收支項目資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmbd_t
(
nmbdent       number(5)      ,/* 企業編號 */
nmbdownid       varchar2(20)      ,/* 資料所有者 */
nmbdowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbdcrtid       varchar2(20)      ,/* 資料建立者 */
nmbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbdcrtdt       timestamp(0)      ,/* 資料創建日 */
nmbdmodid       varchar2(20)      ,/* 資料修改者 */
nmbdmoddt       timestamp(0)      ,/* 最近修改日 */
nmbdstus       varchar2(10)      ,/* 狀態碼 */
nmbd001       varchar2(10)      ,/* 版本 */
nmbd002       varchar2(10)      ,/* 收支項目代碼 */
nmbd003       varchar2(1)      ,/* 項目歸屬 */
nmbd004       varchar2(1)      ,/* 資金加減項 */
nmbd005       varchar2(1)      ,/* 現行版本 */
nmbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbd_t add constraint nmbd_pk primary key (nmbdent,nmbd001,nmbd002) enable validate;

create unique index nmbd_pk on nmbd_t (nmbdent,nmbd001,nmbd002);

grant select on nmbd_t to tiptop;
grant update on nmbd_t to tiptop;
grant delete on nmbd_t to tiptop;
grant insert on nmbd_t to tiptop;

exit;
