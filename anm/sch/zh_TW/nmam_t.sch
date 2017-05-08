/* 
================================================================================
檔案代號:nmam_t
檔案名稱:資金對帳調節碼資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmam_t
(
nmament       number(5)      ,/* 企業編號 */
nmamstus       varchar2(10)      ,/* 狀態碼 */
nmam001       varchar2(10)      ,/* 資金對帳調節碼表編碼 */
nmam002       varchar2(10)      ,/* 調節碼 */
nmam003       varchar2(1)      ,/* 加減方式 */
nmamownid       varchar2(20)      ,/* 資料所有者 */
nmamowndp       varchar2(10)      ,/* 資料所屬部門 */
nmamcrtid       varchar2(20)      ,/* 資料建立者 */
nmamcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmamcrtdt       timestamp(0)      ,/* 資料創建日 */
nmammodid       varchar2(20)      ,/* 資料修改者 */
nmammoddt       timestamp(0)      ,/* 最近修改日 */
nmamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmam_t add constraint nmam_pk primary key (nmament,nmam001,nmam002) enable validate;

create unique index nmam_pk on nmam_t (nmament,nmam001,nmam002);

grant select on nmam_t to tiptop;
grant update on nmam_t to tiptop;
grant delete on nmam_t to tiptop;
grant insert on nmam_t to tiptop;

exit;
