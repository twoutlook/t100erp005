/* 
================================================================================
檔案代號:fabs_t
檔案名稱:資產資本化帳務單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabs_t
(
fabsent       number(5)      ,/* 企業編號 */
fabscomp       varchar2(10)      ,/* 法人 */
fabsld       varchar2(5)      ,/* 帳別編號 */
fabsdocno       varchar2(20)      ,/* 帳務編號 */
fabsseq       number(10,0)      ,/* 項次 */
fabs001       varchar2(10)      ,/* 單據來源 */
fabs002       varchar2(20)      ,/* 來源單號 */
fabs003       number(10,0)      ,/* 來源單項次 */
fabs004       varchar2(20)      ,/* 財產編號 */
fabs005       varchar2(20)      ,/* 附號 */
fabs006       varchar2(10)      ,/* 卡片編號 */
fabs007       varchar2(24)      ,/* 借方科目 */
fabs008       varchar2(24)      ,/* 貸方科目 */
fabs009       varchar2(10)      ,/* 交易幣別 */
fabs010       number(20,10)      ,/* 匯率 */
fabs011       number(20,6)      ,/* 原幣金額 */
fabs012       number(20,6)      ,/* 本幣金額 */
fabs013       varchar2(255)      ,/* 摘要 */
fabs014       varchar2(10)      ,/* 營運據點 */
fabs015       varchar2(10)      ,/* 部門 */
fabs016       varchar2(10)      ,/* 利潤/成本中心 */
fabs017       varchar2(10)      ,/* 區域 */
fabs018       varchar2(10)      ,/* 交易客商 */
fabs019       varchar2(10)      ,/* 帳款客商 */
fabs020       varchar2(10)      ,/* 客群 */
fabs021       varchar2(10)      ,/* 產品類別 */
fabs022       varchar2(20)      ,/* 人員 */
fabs023       varchar2(10)      ,/* 預算編號 */
fabs024       varchar2(20)      ,/* 專案編號 */
fabs025       varchar2(30)      ,/* WBS */
fabs100       varchar2(10)      ,/* 本位幣二幣別 */
fabs101       number(20,10)      ,/* 本位幣二匯率 */
fabs102       number(20,6)      ,/* 本位幣二本幣金額 */
fabs150       varchar2(10)      ,/* 本位幣三幣別 */
fabs151       number(20,10)      ,/* 本位幣三匯率 */
fabs152       number(20,6)      ,/* 本位幣三本幣金額 */
fabsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabs_t add constraint fabs_pk primary key (fabsent,fabsld,fabsdocno,fabsseq) enable validate;

create unique index fabs_pk on fabs_t (fabsent,fabsld,fabsdocno,fabsseq);

grant select on fabs_t to tiptop;
grant update on fabs_t to tiptop;
grant delete on fabs_t to tiptop;
grant insert on fabs_t to tiptop;

exit;
