/* 
================================================================================
檔案代號:stev_t
檔案名稱:交款彙總明細資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stev_t
(
stevent       number(5)      ,/* 企業編號 */
stevsite       varchar2(10)      ,/* 所屬組織 */
stevcomp       varchar2(10)      ,/* 所屬法人 */
stevdocno       varchar2(20)      ,/* 單據編號 */
stevseq       number(10,0)      ,/* 單據項次 */
stev001       varchar2(10)      ,/* 來源類型 */
stev002       varchar2(20)      ,/* 來源單據 */
stev003       number(10,0)      ,/* 來源項次 */
stev004       date      ,/* 來源日期 */
stev005       varchar2(10)      ,/* 費用編號 */
stev006       date      ,/* 起始日期 */
stev007       date      ,/* 截止日期 */
stev008       varchar2(10)      ,/* 幣別 */
stev009       varchar2(10)      ,/* 稅別 */
stev010       varchar2(10)      ,/* 價款類型 */
stev011       number(5,0)      ,/* 方向 */
stev012       number(20,6)      ,/* 價外金額 */
stev013       number(20,6)      ,/* 價內金額 */
stev014       number(20,6)      ,/* 未結算金額 */
stev015       number(20,6)      ,/* 已結算金額 */
stev016       number(20,6)      ,/* 本次結算金額 */
stev017       varchar2(10)      ,/* 結算方式 */
stev018       varchar2(10)      ,/* 結算類型 */
stev019       varchar2(10)      ,/* 所屬品類 */
stev020       varchar2(10)      ,/* 所屬部門 */
stev021       number(20,6)      ,/* 主帳套帳款金額 */
stev022       number(20,6)      ,/* 次帳套一帳款金額 */
stev023       number(20,6)      ,/* 次帳套二帳款金額 */
stev024       varchar2(10)      ,/* 專櫃編號 */
stev025       number(20,6)      ,/* 已交款金額 */
stev026       varchar2(1)      ,/* 納入結算單否 */
stev027       varchar2(1)      ,/* 票扣否 */
stev028       number(20,6)      ,/* 數量 */
stev029       number(20,6)      ,/* 單價 */
stevud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stevud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stevud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stevud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stevud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stevud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stevud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stevud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stevud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stevud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stevud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stevud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stevud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stevud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stevud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stevud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stevud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stevud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stevud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stevud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stevud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stevud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stevud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stevud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stevud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stevud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stevud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stevud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stevud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stevud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stev030       varchar2(255)      /* 備註 */
);
alter table stev_t add constraint stev_pk primary key (stevent,stevdocno,stevseq) enable validate;

create unique index stev_pk on stev_t (stevent,stevdocno,stevseq);

grant select on stev_t to tiptop;
grant update on stev_t to tiptop;
grant delete on stev_t to tiptop;
grant insert on stev_t to tiptop;

exit;
