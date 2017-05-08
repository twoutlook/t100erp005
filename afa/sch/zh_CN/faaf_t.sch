/* 
================================================================================
檔案代號:faaf_t
檔案名稱:多部門折舊費用分攤單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faaf_t
(
faafent       number(5)      ,/* 企業編號 */
faafld       varchar2(5)      ,/* 帳套別編碼 */
faaf001       number(5,0)      ,/* 資料年度 */
faaf002       number(5,0)      ,/* 資料月份 */
faaf003       varchar2(10)      ,/* 分攤類別 */
faaf004       varchar2(10)      ,/* 分攤方式 */
faafownid       varchar2(20)      ,/* 資料所有者 */
faafowndp       varchar2(10)      ,/* 資料所屬部門 */
faafcrtid       varchar2(20)      ,/* 資料建立者 */
faafcrtdp       varchar2(10)      ,/* 資料建立部門 */
faafcrtdt       timestamp(0)      ,/* 資料創建日 */
faafmodid       varchar2(20)      ,/* 資料修改者 */
faafmoddt       timestamp(0)      ,/* 最近修改日 */
faafstus       varchar2(10)      ,/* 狀態碼 */
faafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faaf_t add constraint faaf_pk primary key (faafent,faafld,faaf001,faaf002,faaf003) enable validate;

create unique index faaf_pk on faaf_t (faafent,faafld,faaf001,faaf002,faaf003);

grant select on faaf_t to tiptop;
grant update on faaf_t to tiptop;
grant delete on faaf_t to tiptop;
grant insert on faaf_t to tiptop;

exit;
