/* 
================================================================================
檔案代號:nmai_t
檔案名稱:現金異動碼表檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmai_t
(
nmaient       number(5)      ,/* 企業編號 */
nmaistus       varchar2(10)      ,/* 狀態碼 */
nmai001       varchar2(5)      ,/* 現金異動碼表編碼 */
nmai002       varchar2(10)      ,/* 現金異動碼編碼 */
nmai003       varchar2(10)      ,/* 變動分類碼 */
nmai004       number(10,0)      ,/* 行序 */
nmaiownid       varchar2(20)      ,/* 資料所有者 */
nmaiowndp       varchar2(10)      ,/* 資料所屬部門 */
nmaicrtid       varchar2(20)      ,/* 資料建立者 */
nmaicrtdp       varchar2(10)      ,/* 資料建立部門 */
nmaicrtdt       timestamp(0)      ,/* 資料創建日 */
nmaimodid       varchar2(20)      ,/* 資料修改者 */
nmaimoddt       timestamp(0)      ,/* 最近修改日 */
nmaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmai_t add constraint nmai_pk primary key (nmaient,nmai001,nmai002) enable validate;

create unique index nmai_pk on nmai_t (nmaient,nmai001,nmai002);

grant select on nmai_t to tiptop;
grant update on nmai_t to tiptop;
grant delete on nmai_t to tiptop;
grant insert on nmai_t to tiptop;

exit;
