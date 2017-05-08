/* 
================================================================================
檔案代號:qcae_t
檔案名稱:1916檢驗水準抽樣計劃檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcae_t
(
qcaestus       varchar2(10)      ,/* 狀態碼 */
qcaeent       number(5)      ,/* 企業編號 */
qcae001       varchar2(10)      ,/* 檢驗水準 */
qcae002       varchar2(10)      ,/* 級數 */
qcae003       varchar2(1)      ,/* 樣本字號 */
qcae004       number(5,0)      ,/* 抽樣數 */
qcae005       number(5,3)      ,/* K法標準值 */
qcae006       number(5,3)      ,/* F法標準值 */
qcaeownid       varchar2(20)      ,/* 資料所有者 */
qcaeowndp       varchar2(10)      ,/* 資料所屬部門 */
qcaecrtid       varchar2(20)      ,/* 資料建立者 */
qcaecrtdp       varchar2(10)      ,/* 資料建立部門 */
qcaecrtdt       timestamp(0)      ,/* 資料創建日 */
qcaemodid       varchar2(20)      ,/* 資料修改者 */
qcaemoddt       timestamp(0)      ,/* 最近修改日 */
qcaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcae_t add constraint qcae_pk primary key (qcaeent,qcae001,qcae002,qcae003) enable validate;

create unique index qcae_pk on qcae_t (qcaeent,qcae001,qcae002,qcae003);

grant select on qcae_t to tiptop;
grant update on qcae_t to tiptop;
grant delete on qcae_t to tiptop;
grant insert on qcae_t to tiptop;

exit;
