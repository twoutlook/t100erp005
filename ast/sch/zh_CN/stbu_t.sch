/* 
================================================================================
檔案代號:stbu_t
檔案名稱:結算單明細資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbu_t
(
stbuent       number(5)      ,/* 企業編號 */
stbusite       varchar2(10)      ,/* 營運據點 */
stbucomp       varchar2(10)      ,/* 所屬法人 */
stbudocno       varchar2(20)      ,/* 單據編號 */
stbuseq       number(10,0)      ,/* 單據項次 */
stbu001       varchar2(10)      ,/* 來源類型 */
stbu002       varchar2(20)      ,/* 來源單據 */
stbu003       number(10,0)      ,/* 來源項次 */
stbu004       date      ,/* 來源日期 */
stbu005       varchar2(10)      ,/* 費用編號 */
stbu006       date      ,/* 起始日期 */
stbu007       date      ,/* 截止日期 */
stbu008       varchar2(10)      ,/* 幣別 */
stbu009       varchar2(10)      ,/* 稅別 */
stbu010       varchar2(10)      ,/* 價款類型 */
stbu011       number(5,0)      ,/* 方向 */
stbu012       number(20,6)      ,/* 價外金額 */
stbu013       number(20,6)      ,/* 價內金額 */
stbu014       number(20,6)      ,/* 未結算金額 */
stbu015       number(20,6)      ,/* 已結算金額 */
stbu016       number(20,6)      ,/* 本次結算金額 */
stbu017       varchar2(10)      ,/* 結算方式 */
stbu018       varchar2(10)      ,/* 結算類型 */
stbu019       varchar2(10)      ,/* 所屬品類 */
stbu020       varchar2(10)      ,/* 所屬部門 */
stbu021       number(10,0)      ,/* 結算會計期 */
stbu022       number(5,0)      ,/* 財務會計年度 */
stbu023       number(5,0)      ,/* 財務會計期別 */
stbu024       number(20,6)      ,/* 主帳套已立賬金額 */
stbu025       number(20,6)      ,/* 帳套二已立賬金額 */
stbu026       number(20,6)      ,/* 帳套三已立賬金額 */
stbu027       number(20,10)      ,/* 匯率 */
stbuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stbu_t add constraint stbu_pk primary key (stbuent,stbudocno,stbuseq) enable validate;

create unique index stbu_pk on stbu_t (stbuent,stbudocno,stbuseq);

grant select on stbu_t to tiptop;
grant update on stbu_t to tiptop;
grant delete on stbu_t to tiptop;
grant insert on stbu_t to tiptop;

exit;
