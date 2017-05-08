/* 
================================================================================
檔案代號:sfcg_t
檔案名稱:RunCard合併記錄單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfcg_t
(
sfcgent       number(5)      ,/* 企業編號 */
sfcgsite       varchar2(10)      ,/* 營運據點 */
sfcgdocno       varchar2(20)      ,/* 工單單號 */
sfcgdocdt       date      ,/* 合併日期 */
sfcg001       number(10,0)      ,/* 合併版本 */
sfcg002       varchar2(10)      ,/* 作業編號 */
sfcg003       varchar2(10)      ,/* 作業序 */
sfcg004       number(10,0)      ,/* 新RunCard編號 */
sfcg005       number(20,6)      ,/* 合併轉入數量 */
sfcgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfcgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfcgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfcgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfcgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfcgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfcgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfcgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfcgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfcgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfcgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfcgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfcgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfcgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfcgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfcgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfcgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfcgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfcgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfcgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfcgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfcgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfcgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfcgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfcgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfcgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfcgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfcgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfcgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfcgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfcg_t add constraint sfcg_pk primary key (sfcgent,sfcgdocno,sfcg001) enable validate;

create unique index sfcg_pk on sfcg_t (sfcgent,sfcgdocno,sfcg001);

grant select on sfcg_t to tiptop;
grant update on sfcg_t to tiptop;
grant delete on sfcg_t to tiptop;
grant insert on sfcg_t to tiptop;

exit;
