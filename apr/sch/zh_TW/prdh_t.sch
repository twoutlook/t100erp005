/* 
================================================================================
檔案代號:prdh_t
檔案名稱:促銷規則申請條件資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdh_t
(
prdhent       number(5)      ,/* 企業編號 */
prdhunit       varchar2(10)      ,/* 應用組織 */
prdhsite       varchar2(10)      ,/* 營運據點 */
prdhdocno       varchar2(20)      ,/* 促銷申請單號 */
prdh000       varchar2(10)      ,/* 條件分類 */
prdh001       varchar2(20)      ,/* 規則編號 */
prdh002       number(10,0)      ,/* 組別 */
prdh003       varchar2(10)      ,/* 條件類型 */
prdh004       varchar2(10)      ,/* 參與方式 */
prdh005       number(20,6)      ,/* 金額/數量 */
prdh006       number(10,0)      ,/* 基數 */
prdh007       number(10,0)      ,/* 幅度 */
prdh008       varchar2(10)      ,/* 商品條件 */
prdh009       varchar2(10)      ,/* 促銷方式 */
prdh010       varchar2(1)      ,/* 常規搭贈 */
prdh011       number(20,6)      ,/* 承擔比例 */
prdh012       number(20,6)      ,/* 目標數量 */
prdh013       number(20,6)      ,/* 目標金額 */
prdhacti       varchar2(10)      ,/* 有效否 */
prdhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdhud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdh014       varchar2(1)      ,/* 整倍計算否 */
prdh015       varchar2(10)      ,/* 返現金額類型 */
prdh016       varchar2(10)      /* 返現方式 */
);
alter table prdh_t add constraint prdh_pk primary key (prdhent,prdhdocno,prdh002) enable validate;

create unique index prdh_pk on prdh_t (prdhent,prdhdocno,prdh002);

grant select on prdh_t to tiptop;
grant update on prdh_t to tiptop;
grant delete on prdh_t to tiptop;
grant insert on prdh_t to tiptop;

exit;
