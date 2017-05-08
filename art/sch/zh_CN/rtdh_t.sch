/* 
================================================================================
檔案代號:rtdh_t
檔案名稱:供應商生命週期調整明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdh_t
(
rtdhent       number(5)      ,/* 企業編號 */
rtdhsite       varchar2(10)      ,/* 營運組織 */
rtdhunit       varchar2(10)      ,/* 應用組織 */
rtdhdocno       varchar2(20)      ,/* 單據編號 */
rtdhseq       number(10,0)      ,/* 項次 */
rtdh001       varchar2(10)      ,/* 供應商編號 */
rtdh002       varchar2(10)      ,/* 原生命周期 */
rtdh003       varchar2(10)      ,/* 新生命週期 */
rtdhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdh_t add constraint rtdh_pk primary key (rtdhent,rtdhdocno,rtdhseq) enable validate;

create unique index rtdh_pk on rtdh_t (rtdhent,rtdhdocno,rtdhseq);

grant select on rtdh_t to tiptop;
grant update on rtdh_t to tiptop;
grant delete on rtdh_t to tiptop;
grant insert on rtdh_t to tiptop;

exit;
