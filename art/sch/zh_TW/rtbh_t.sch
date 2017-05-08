/* 
================================================================================
檔案代號:rtbh_t
檔案名稱:商品主供應商調整單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtbh_t
(
rtbhent       number(5)      ,/* 企業代碼 */
rtbhsite       varchar2(10)      ,/* 營運據點 */
rtbhunit       varchar2(10)      ,/* 制定組織 */
rtbhdocno       varchar2(20)      ,/* 單號 */
rtbhseq       number(10,0)      ,/* 項次 */
rtbh001       varchar2(40)      ,/* 商品主條碼 */
rtbh002       varchar2(40)      ,/* 商品編號 */
rtbh003       varchar2(10)      ,/* 原默認供應商 */
rtbh004       varchar2(10)      ,/* 供應商編號 */
rtbh005       varchar2(10)      ,/* 原結算方式 */
rtbh006       varchar2(10)      ,/* 新結算方式 */
rtbh007       varchar2(20)      ,/* 原合同 */
rtbh008       varchar2(20)      ,/* 新合同 */
rtbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtbh_t add constraint rtbh_pk primary key (rtbhent,rtbhdocno,rtbhseq) enable validate;

create unique index rtbh_pk on rtbh_t (rtbhent,rtbhdocno,rtbhseq);

grant select on rtbh_t to tiptop;
grant update on rtbh_t to tiptop;
grant delete on rtbh_t to tiptop;
grant insert on rtbh_t to tiptop;

exit;
