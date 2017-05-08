/* 
================================================================================
檔案代號:bmfb_t
檔案名稱:ECN下階料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfb_t
(
bmfbent       number(5)      ,/* 企業編號 */
bmfbsite       varchar2(10)      ,/* 營運據點 */
bmfbdocno       varchar2(20)      ,/* ECN單號 */
bmfb002       number(10,0)      ,/* 項次 */
bmfb003       varchar2(10)      ,/* 變更方式 */
bmfb004       number(10,0)      ,/* BOM項次 */
bmfb005       varchar2(40)      ,/* 元件料號 */
bmfb006       varchar2(40)      ,/* 新元件料號 */
bmfb007       varchar2(10)      ,/* 舊元件處理方式 */
bmfb008       varchar2(10)      ,/* 部位 */
bmfb009       varchar2(10)      ,/* 作業 */
bmfb010       varchar2(10)      ,/* 作業序 */
bmfb011       number(20,6)      ,/* 組成用量 */
bmfb012       number(20,6)      ,/* 主件底數 */
bmfb013       varchar2(10)      ,/* 用量單位 */
bmfb014       varchar2(1)      ,/* 公式用量 */
bmfb015       varchar2(10)      ,/* 公式 */
bmfb016       varchar2(10)      ,/* 必要 */
bmfb017       varchar2(1)      ,/* 特徵管理 */
bmfb018       varchar2(1)      ,/* 選配件 */
bmfb019       varchar2(1)      ,/* 備品 */
bmfb020       varchar2(1)      ,/* 插件位置 */
bmfb021       varchar2(10)      ,/* 損耗率型態 */
bmfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfb_t add constraint bmfb_pk primary key (bmfbent,bmfbsite,bmfbdocno,bmfb002) enable validate;

create unique index bmfb_pk on bmfb_t (bmfbent,bmfbsite,bmfbdocno,bmfb002);

grant select on bmfb_t to tiptop;
grant update on bmfb_t to tiptop;
grant delete on bmfb_t to tiptop;
grant insert on bmfb_t to tiptop;

exit;
