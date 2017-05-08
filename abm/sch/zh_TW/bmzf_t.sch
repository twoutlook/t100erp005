/* 
================================================================================
檔案代號:bmzf_t
檔案名稱:BOM用量公式參數檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmzf_t
(
bmzfent       number(5)      ,/* 企業編號 */
bmzf001       varchar2(10)      ,/* 公式代號 */
bmzf002       number(10,0)      ,/* 項次 */
bmzf003       varchar2(80)      ,/* 說明 */
bmzf004       varchar2(10)      ,/* 來源 */
bmzf005       varchar2(10)      ,/* 來源檔案 */
bmzf006       varchar2(20)      ,/* 來源欄位 */
bmzf007       varchar2(30)      ,/* 特徵 */
bmzf008       number(20,6)      ,/* 固定值 */
bmzfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmzfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmzfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmzfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmzfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmzfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmzfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmzfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmzfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmzfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmzfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmzfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmzfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmzfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmzfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmzfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmzfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmzfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmzfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmzfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmzfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmzfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmzfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmzfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmzfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmzfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmzfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmzfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmzfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmzfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmzf_t add constraint bmzf_pk primary key (bmzfent,bmzf001,bmzf002) enable validate;

create  index bmzf_01 on bmzf_t (bmzf001,bmzf002);
create unique index bmzf_pk on bmzf_t (bmzfent,bmzf001,bmzf002);

grant select on bmzf_t to tiptop;
grant update on bmzf_t to tiptop;
grant delete on bmzf_t to tiptop;
grant insert on bmzf_t to tiptop;

exit;
