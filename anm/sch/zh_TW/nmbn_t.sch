/* 
================================================================================
檔案代號:nmbn_t
檔案名稱:資金排程項目資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table nmbn_t
(
nmbnent       number(5)      ,/* 企業編碼 */
nmbn001       varchar2(10)      ,/* 收支代碼 */
nmbnstus       varchar2(1)      ,/* 有效碼 */
nmbnownid       varchar2(20)      ,/* 資料所有者 */
nmbnowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbncrtid       varchar2(20)      ,/* 資料建立者 */
nmbncrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbncrtdt       timestamp(0)      ,/* 資料創建日 */
nmbnmodid       varchar2(20)      ,/* 資料修改者 */
nmbnmoddt       timestamp(0)      ,/* 最近修改日 */
nmbnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbn_t add constraint nmbn_pk primary key (nmbnent,nmbn001) enable validate;

create unique index nmbn_pk on nmbn_t (nmbnent,nmbn001);

grant select on nmbn_t to tiptop;
grant update on nmbn_t to tiptop;
grant delete on nmbn_t to tiptop;
grant insert on nmbn_t to tiptop;

exit;
