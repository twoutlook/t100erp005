/* 
================================================================================
檔案代號:pmdh_t
檔案名稱:詢價分量計價檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdh_t
(
pmdhent       number(5)      ,/* 企業編號 */
pmdhsite       varchar2(10)      ,/* 營運據點 */
pmdhdocno       varchar2(20)      ,/* 詢價單號 */
pmdhseq       number(10,0)      ,/* 項次 */
pmdh001       number(20,6)      ,/* 起始數量 */
pmdh002       number(20,6)      ,/* 截止數量 */
pmdh003       number(20,6)      ,/* 單價 */
pmdh004       number(20,6)      ,/* 折扣率 */
pmdhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdh_t add constraint pmdh_pk primary key (pmdhent,pmdhdocno,pmdhseq,pmdh001,pmdh002) enable validate;

create unique index pmdh_pk on pmdh_t (pmdhent,pmdhdocno,pmdhseq,pmdh001,pmdh002);

grant select on pmdh_t to tiptop;
grant update on pmdh_t to tiptop;
grant delete on pmdh_t to tiptop;
grant insert on pmdh_t to tiptop;

exit;
