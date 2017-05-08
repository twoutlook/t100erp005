/* 
================================================================================
檔案代號:stdh_t
檔案名稱:內部結算單明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stdh_t
(
stdhent       number(5)      ,/* 企業編號 */
stdhunit       varchar2(10)      ,/* 應用組織 */
stdhsite       varchar2(10)      ,/* 營運據點 */
stdhdocno       varchar2(20)      ,/* 單據編號 */
stdhseq       number(10,0)      ,/* 單據項次 */
stdh001       varchar2(10)      ,/* 業務類型 */
stdh002       varchar2(10)      ,/* 內部交易類型 */
stdh003       varchar2(20)      ,/* 來源單據 */
stdh004       number(10,0)      ,/* 來源項次 */
stdh005       date      ,/* 來源日期 */
stdh006       varchar2(40)      ,/* 產品編號 */
stdh007       varchar2(10)      ,/* 費用編號 */
stdh008       varchar2(10)      ,/* 幣別 */
stdh009       varchar2(10)      ,/* 稅別 */
stdh010       number(5,0)      ,/* 方向 */
stdh011       number(20,6)      ,/* 未稅金額 */
stdh012       number(20,6)      ,/* 含稅金額 */
stdh013       number(20,6)      ,/* 未結算金額 */
stdh014       number(20,6)      ,/* 已結算金額 */
stdh015       number(20,6)      ,/* 本次結算金額 */
stdh016       varchar2(10)      ,/* 存貨組織 */
stdh017       varchar2(10)      ,/* 存貨法人 */
stdh018       varchar2(10)      ,/* 倉庫編碼 */
stdh019       varchar2(10)      ,/* 交易對象 */
stdh020       varchar2(10)      ,/* 交易對象組織 */
stdh021       varchar2(10)      ,/* 交易對象法人 */
stdh022       number(10,0)      ,/* 結算會計期 */
stdh023       number(5,0)      ,/* 財務會計年度 */
stdh024       number(5,0)      ,/* 財務會計期別 */
stdh025       varchar2(10)      ,/* 賬務組織 */
stdh026       varchar2(10)      ,/* 賬務法人 */
stdh027       varchar2(10)      ,/* 賬務類型 */
stdh028       number(20,6)      ,/* 主帳套已立賬金額 */
stdh029       number(20,6)      ,/* 帳套二已立賬金額 */
stdh030       number(20,6)      ,/* 帳套三已立賬金額 */
stdhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdhud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stdh031       number(10,0)      ,/* 來源項序 */
stdh032       number(5,0)      /* 出入庫碼 */
);
alter table stdh_t add constraint stdh_pk primary key (stdhent,stdhdocno,stdhseq) enable validate;

create unique index stdh_pk on stdh_t (stdhent,stdhdocno,stdhseq);

grant select on stdh_t to tiptop;
grant update on stdh_t to tiptop;
grant delete on stdh_t to tiptop;
grant insert on stdh_t to tiptop;

exit;
