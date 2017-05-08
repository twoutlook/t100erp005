/* 
================================================================================
檔案代號:bxdg_t
檔案名稱:保稅機器設備盤點底稿單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxdg_t
(
bxdgent       number(5)      ,/* 企業編號 */
bxdgsite       varchar2(10)      ,/* 營運據點 */
bxdgdocno       varchar2(20)      ,/* 盤點單號 */
bxdgseq       number(10,0)      ,/* 項次 */
bxdg001       varchar2(20)      ,/* 機器裝置編號 */
bxdg002       number(10,0)      ,/* 序號 */
bxdg003       number(20,6)      ,/* 帳面結餘數量 */
bxdg004       number(20,6)      ,/* 外送數量 */
bxdg005       number(20,6)      ,/* 盤點數量 */
bxdg006       varchar2(255)      ,/* 備註 */
bxdgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdg_t add constraint bxdg_pk primary key (bxdgent,bxdgdocno,bxdgseq) enable validate;

create unique index bxdg_pk on bxdg_t (bxdgent,bxdgdocno,bxdgseq);

grant select on bxdg_t to tiptop;
grant update on bxdg_t to tiptop;
grant delete on bxdg_t to tiptop;
grant insert on bxdg_t to tiptop;

exit;
