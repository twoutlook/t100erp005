/* 
================================================================================
檔案代號:glam_t
檔案名稱:常用分攤傳票單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table glam_t
(
glament       number(5)      ,/* 企業編號 */
glamld       varchar2(5)      ,/* 帳別(套)編號 */
glamcomp       varchar2(10)      ,/* 營運據點(法人 */
glamdocno       varchar2(20)      ,/* 分攤編號 */
glamseq       number(10,0)      ,/* 項次 */
glam001       varchar2(4000)      ,/* 摘要 */
glam002       varchar2(24)      ,/* 科目編號 */
glam003       number(20,6)      ,/* 借方金額/比率 */
glam004       number(20,6)      ,/* 貸方金額/比率 */
glam005       varchar2(24)      ,/* 借方變動比率分子科目 */
glam006       varchar2(24)      ,/* 貸方變動比率分子科目 */
glam007       varchar2(10)      ,/* 營運據點 */
glam008       varchar2(10)      ,/* 部門 */
glam009       varchar2(10)      ,/* 利潤/成本中心 */
glam010       varchar2(10)      ,/* 區域 */
glam011       varchar2(10)      ,/* 交易客商 */
glam012       varchar2(10)      ,/* 帳款客商 */
glam013       varchar2(10)      ,/* 客群 */
glam014       varchar2(10)      ,/* 產品類別 */
glam015       varchar2(20)      ,/* 人員 */
glam016       varchar2(10)      ,/* no use */
glam017       varchar2(20)      ,/* 專案編號 */
glam018       varchar2(30)      ,/* WBS */
glam019       varchar2(10)      ,/* 營運據點(借) */
glam020       varchar2(10)      ,/* 部門(借) */
glam021       varchar2(10)      ,/* 利潤/成本中心(借) */
glam022       varchar2(10)      ,/* 區域(借) */
glam023       varchar2(10)      ,/* 交易客商(借) */
glam024       varchar2(10)      ,/* 帳款客商(借) */
glam025       varchar2(10)      ,/* 客群(借) */
glam026       varchar2(10)      ,/* 產品類別(借) */
glam027       varchar2(20)      ,/* 人員(借) */
glam028       varchar2(10)      ,/* no use */
glam029       varchar2(20)      ,/* 專案編號(借) */
glam030       varchar2(30)      ,/* WBS(借) */
glam031       varchar2(10)      ,/* 營運據點(貸) */
glam032       varchar2(10)      ,/* 部門(貸) */
glam033       varchar2(10)      ,/* 利潤/成本中心(貸) */
glam034       varchar2(10)      ,/* 區域(貸) */
glam035       varchar2(10)      ,/* 交易客商(貸) */
glam036       varchar2(10)      ,/* 帳款客商(貸) */
glam037       varchar2(10)      ,/* 客群(貸) */
glam038       varchar2(10)      ,/* 產品類別(貸) */
glam039       varchar2(20)      ,/* 人員(貸) */
glam040       varchar2(10)      ,/* no use */
glam041       varchar2(20)      ,/* 專案編號(貸) */
glam042       varchar2(30)      ,/* WBS(貸) */
glam043       number(20,10)      ,/* 匯率(本位幣二) */
glam044       number(20,6)      ,/* 借方金額(本位幣二) */
glam045       number(20,6)      ,/* 貸方金額(本位幣二) */
glam046       number(20,10)      ,/* 匯率(本位幣三) */
glam047       number(20,6)      ,/* 借方金額(本位幣三) */
glam048       number(20,6)      ,/* 貸方金額(本位幣三) */
glam051       varchar2(10)      ,/* 經營方式 */
glam052       varchar2(10)      ,/* 渠道 */
glam053       varchar2(10)      ,/* 品牌 */
glam054       varchar2(10)      ,/* 經營方式(借) */
glam055       varchar2(10)      ,/* 渠道(借) */
glam056       varchar2(10)      ,/* 品牌(借) */
glam057       varchar2(10)      ,/* 經營方式(貸) */
glam058       varchar2(10)      ,/* 渠道(貸) */
glam059       varchar2(10)      ,/* 品牌(貸) */
glamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glam_t add constraint glam_pk primary key (glament,glamld,glamdocno,glamseq) enable validate;

create unique index glam_pk on glam_t (glament,glamld,glamdocno,glamseq);

grant select on glam_t to tiptop;
grant update on glam_t to tiptop;
grant delete on glam_t to tiptop;
grant insert on glam_t to tiptop;

exit;
