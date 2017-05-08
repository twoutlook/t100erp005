/* 
================================================================================
檔案代號:sfae_t
檔案名稱:工單計劃完工日期檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfae_t
(
sfaeent       number(5)      ,/* 企業編號 */
sfaesite       varchar2(10)      ,/* 營運據點 */
sfaedocno       varchar2(20)      ,/* 單號 */
sfaeseq       number(10,0)      ,/* 項次 */
sfae001       number(20,6)      ,/* 數量 */
sfae002       date      ,/* 預計完工日期 */
sfae003       date      ,/* 累計數量達成日 */
sfae004       number(5,0)      ,/* 修正次數 */
sfae005       varchar2(20)      ,/* 修改人員 */
sfae006       date      ,/* 修改日期 */
sfaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfae_t add constraint sfae_pk primary key (sfaeent,sfaedocno,sfaeseq) enable validate;

create unique index sfae_pk on sfae_t (sfaeent,sfaedocno,sfaeseq);

grant select on sfae_t to tiptop;
grant update on sfae_t to tiptop;
grant delete on sfae_t to tiptop;
grant insert on sfae_t to tiptop;

exit;
