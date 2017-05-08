/* 
================================================================================
檔案代號:bmfm_t
檔案名稱:ECN元件限定庫存特徵單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfm_t
(
bmfment       number(5)      ,/* 企業編號 */
bmfmsite       varchar2(10)      ,/* 營運據點 */
bmfmdocno       varchar2(20)      ,/* ECN單號 */
bmfm002       number(10,0)      ,/* ECN項次 */
bmfm003       varchar2(30)      ,/* 特徵代碼 */
bmfm004       varchar2(30)      ,/* 特徵值 */
bmfmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfm_t add constraint bmfm_pk primary key (bmfment,bmfmsite,bmfmdocno,bmfm002,bmfm003) enable validate;

create unique index bmfm_pk on bmfm_t (bmfment,bmfmsite,bmfmdocno,bmfm002,bmfm003);

grant select on bmfm_t to tiptop;
grant update on bmfm_t to tiptop;
grant delete on bmfm_t to tiptop;
grant insert on bmfm_t to tiptop;

exit;
