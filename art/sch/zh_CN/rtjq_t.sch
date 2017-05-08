/* 
================================================================================
檔案代號:rtjq_t
檔案名稱:銷售整合發票歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtjq_t
(
rtjqent       number(5)      ,/* 企業編號 */
rtjqsite       varchar2(10)      ,/* 營運據點 */
rtjqunit       varchar2(10)      ,/* 應用組織 */
rtjqdocno       varchar2(20)      ,/* 單據編號 */
rtjqseq       number(10,0)      ,/* 項次 */
rtjqseq1       number(10,0)      ,/* 發票序 */
rtjq001       date      ,/* 發票日期 */
rtjq002       varchar2(20)      ,/* 發票起始號碼 */
rtjq003       varchar2(20)      ,/* 發票截止號碼 */
rtjq004       varchar2(20)      ,/* 電子發票隨機碼 */
rtjq005       varchar2(1)      ,/* 電子發票否 */
rtjq006       number(20,6)      ,/* 發票未稅金額 */
rtjq007       number(20,6)      ,/* 發票稅額 */
rtjq008       number(20,6)      ,/* 發票應稅金額 */
rtjq009       number(20,6)      ,/* 禮券已開發票金額 */
rtjq010       number(20,6)      ,/* 禮券已開發票稅額 */
rtjq011       number(20,6)      ,/* 已開發票留抵稅額 */
rtjq012       varchar2(10)      ,/* 稅別 */
rtjq013       number(5,0)      ,/* 列印次數 */
rtjq014       varchar2(10)      ,/* 發票狀態 */
rtjq015       varchar2(10)      ,/* 發票狀態異動理由碼 */
rtjq016       varchar2(20)      ,/* 發票狀態異動人員 */
rtjq017       date      ,/* 發票狀態異動日期 */
rtjq018       timestamp(5)      ,/* 發票狀態異動時間 */
rtjq019       varchar2(10)      ,/* 發票聯別 */
rtjq020       varchar2(20)      ,/* 折讓單單號 */
rtjq021       varchar2(20)      ,/* 買方統一編號 */
rtjq022       varchar2(20)      ,/* 賣方統一編號 */
rtjq023       varchar2(10)      ,/* 媒體申報格式 */
rtjq024       varchar2(10)      ,/* 載具類別編號 */
rtjq025       varchar2(80)      ,/* 載具顯碼ID */
rtjq026       varchar2(80)      ,/* 載具隱碼ID */
rtjq027       varchar2(10)      ,/* 愛心碼 */
rtjq028       number(5,0)      ,/* 歷程項次 */
rtjq029       varchar2(20)      ,/* 單據來源 */
rtjq030       varchar2(20)      ,/* 發票代碼 */
rtjqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtjq_t add constraint rtjq_pk primary key (rtjqent,rtjqdocno,rtjqseq,rtjqseq1) enable validate;

create unique index rtjq_pk on rtjq_t (rtjqent,rtjqdocno,rtjqseq,rtjqseq1);

grant select on rtjq_t to tiptop;
grant update on rtjq_t to tiptop;
grant delete on rtjq_t to tiptop;
grant insert on rtjq_t to tiptop;

exit;
