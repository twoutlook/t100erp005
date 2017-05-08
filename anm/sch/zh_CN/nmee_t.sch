/* 
================================================================================
檔案代號:nmee_t
檔案名稱:交款匯總收款明細資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmee_t
(
nmeeent       number(5)      ,/* 企業編號 */
nmeesite       varchar2(10)      ,/* 所屬組織 */
nmeecomp       varchar2(10)      ,/* 所屬法人 */
nmeedocno       varchar2(20)      ,/* 單據編號 */
nmeeseq       number(10,0)      ,/* 單據項次 */
nmee001       varchar2(10)      ,/* 交易對象 */
nmee002       varchar2(20)      ,/* 結算方式 */
nmee003       varchar2(20)      ,/* 來源單據編號 */
nmee004       number(10,0)      ,/* 來源單據項次 */
nmee005       varchar2(10)      ,/* 專櫃編號 */
nmee006       varchar2(10)      ,/* 費用編號 */
nmee007       date      ,/* 起始日期 */
nmee008       date      ,/* 截止日期 */
nmee009       varchar2(10)      ,/* 幣別 */
nmee010       varchar2(10)      ,/* 稅別 */
nmee011       number(5,0)      ,/* 方向 */
nmee012       number(20,6)      ,/* 本次結算金額 */
nmee013       varchar2(10)      ,/* 結算類型 */
nmee014       varchar2(10)      ,/* 所屬部門 */
nmee015       number(10)      ,/* 異動別 */
nmee016       varchar2(10)      ,/* 存提碼 */
nmee017       varchar2(10)      ,/* 現金變動碼 */
nmee018       number(20,10)      ,/* 匯率 */
nmeeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmeeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmeeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmeeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmeeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmeeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmeeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmeeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmeeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmeeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmeeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmeeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmeeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmeeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmeeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmeeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmeeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmeeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmeeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmeeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmeeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmeeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmeeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmeeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmeeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmeeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmeeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmeeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmeeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmeeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmee019       varchar2(10)      ,/* 所屬品類 */
nmee020       varchar2(1)      ,/* 預收否 */
nmee021       varchar2(20)      ,/* 預收待抵單 */
nmee022       varchar2(1)      ,/* 來源類型 */
nmee023       varchar2(255)      /* 備註 */
);
alter table nmee_t add constraint nmee_pk primary key (nmeeent,nmeecomp,nmeedocno,nmeeseq) enable validate;

create unique index nmee_pk on nmee_t (nmeeent,nmeecomp,nmeedocno,nmeeseq);

grant select on nmee_t to tiptop;
grant update on nmee_t to tiptop;
grant delete on nmee_t to tiptop;
grant insert on nmee_t to tiptop;

exit;
