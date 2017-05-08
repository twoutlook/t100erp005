/* 
================================================================================
檔案代號:nmaj_t
檔案名稱:銀行存提碼表資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmaj_t
(
nmajent       number(5)      ,/* 企業編號 */
nmajownid       varchar2(20)      ,/* 資料所有者 */
nmajowndp       varchar2(10)      ,/* 資料所屬部門 */
nmajcrtid       varchar2(20)      ,/* 資料建立者 */
nmajcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmajcrtdt       timestamp(0)      ,/* 資料創建日 */
nmajmodid       varchar2(20)      ,/* 資料修改者 */
nmajmoddt       timestamp(0)      ,/* 最近修改日 */
nmajstus       varchar2(10)      ,/* 狀態碼 */
nmaj001       varchar2(10)      ,/* 銀行存提編碼 */
nmaj002       varchar2(1)      ,/* 存提 */
nmajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmaj_t add constraint nmaj_pk primary key (nmajent,nmaj001) enable validate;

create unique index nmaj_pk on nmaj_t (nmajent,nmaj001);

grant select on nmaj_t to tiptop;
grant update on nmaj_t to tiptop;
grant delete on nmaj_t to tiptop;
grant insert on nmaj_t to tiptop;

exit;
