/* 
================================================================================
檔案代號:imdb_t
檔案名稱:料件引入營運據點料件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imdb_t
(
imdbent       number(5)      ,/* 企業編號 */
imdbstus       varchar2(10)      ,/* 狀態碼 */
imdb001       varchar2(10)      ,/* 營運據點 */
imdb002       varchar2(40)      ,/* 料件編號 */
imdb003       varchar2(10)      ,/* 引入方式 */
imdb004       varchar2(10)      ,/* 補給策略 */
imdb005       varchar2(1)      ,/* BOM引入 */
imdbownid       varchar2(20)      ,/* 資料所有者 */
imdbowndp       varchar2(10)      ,/* 資料所屬部門 */
imdbcrtid       varchar2(20)      ,/* 資料建立者 */
imdbcrtdt       timestamp(0)      ,/* 資料創建日 */
imdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
imdbmodid       varchar2(20)      ,/* 資料修改者 */
imdbmoddt       timestamp(0)      ,/* 最近修改日 */
imdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imdb_t add constraint imdb_pk primary key (imdbent,imdb001,imdb002) enable validate;

create  index imdb_01 on imdb_t (imdb001,imdb002);
create unique index imdb_pk on imdb_t (imdbent,imdb001,imdb002);

grant select on imdb_t to tiptop;
grant update on imdb_t to tiptop;
grant delete on imdb_t to tiptop;
grant insert on imdb_t to tiptop;

exit;
