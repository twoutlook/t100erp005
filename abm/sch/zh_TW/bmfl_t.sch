/* 
================================================================================
檔案代號:bmfl_t
檔案名稱:ECN特對應單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfl_t
(
bmflent       number(5)      ,/* 企業編號 */
bmflsite       varchar2(10)      ,/* 營運據點 */
bmfldocno       varchar2(20)      ,/* ECN單號 */
bmfl002       number(10,0)      ,/* ECN項次 */
bmfl003       varchar2(30)      ,/* 特徵代碼 */
bmfl004       varchar2(30)      ,/* 主件特徵值 */
bmfl005       varchar2(30)      ,/* 元件特徵值 */
bmflud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmflud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmflud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmflud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmflud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmflud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmflud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmflud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmflud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmflud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmflud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmflud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmflud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmflud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmflud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmflud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmflud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmflud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmflud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmflud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmflud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmflud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmflud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmflud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmflud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmflud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmflud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmflud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmflud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmflud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfl_t add constraint bmfl_pk primary key (bmflent,bmflsite,bmfldocno,bmfl002,bmfl003,bmfl004) enable validate;

create unique index bmfl_pk on bmfl_t (bmflent,bmflsite,bmfldocno,bmfl002,bmfl003,bmfl004);

grant select on bmfl_t to tiptop;
grant update on bmfl_t to tiptop;
grant delete on bmfl_t to tiptop;
grant insert on bmfl_t to tiptop;

exit;
