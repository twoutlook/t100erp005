/* 
================================================================================
檔案代號:nmbv_t
檔案名稱:帳務底稿科目明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmbv_t
(
nmbvent       number(5)      ,/* 企業編號 */
nmbvcomp       varchar2(10)      ,/* 法人 */
nmbvld       varchar2(5)      ,/* 帳套(套)編號 */
nmbvdocno       varchar2(20)      ,/* 帳務編號 */
nmbvseq       number(10,0)      ,/* 項次 */
nmbvseq2       number(10,0)      ,/* 分項項次 */
nmbv001       varchar2(20)      ,/* 對方分項科目編號 */
nmbv017       varchar2(10)      ,/* 營運據點 */
nmbv018       varchar2(10)      ,/* 部門 */
nmbv019       varchar2(10)      ,/* 利潤/成本中心 */
nmbv020       varchar2(10)      ,/* 區域 */
nmbv021       varchar2(10)      ,/* 交易客戶 */
nmbv022       varchar2(10)      ,/* 帳款客戶 */
nmbv023       varchar2(10)      ,/* 客群 */
nmbv024       varchar2(10)      ,/* 產品類別 */
nmbv025       varchar2(20)      ,/* 人員 */
nmbv026       varchar2(10)      ,/* 預算編號 */
nmbv027       varchar2(20)      ,/* 專案編號 */
nmbv028       varchar2(30)      ,/* WBS */
nmbv029       varchar2(30)      ,/* 自由核算項(一) */
nmbv030       varchar2(30)      ,/* 自由核算項(二) */
nmbv031       varchar2(30)      ,/* 自由核算項(三) */
nmbv032       varchar2(30)      ,/* 自由核算項(四) */
nmbv033       varchar2(30)      ,/* 自由核算項(五) */
nmbv034       varchar2(30)      ,/* 自由核算項(六) */
nmbv035       varchar2(30)      ,/* 自由核算項(七) */
nmbv036       varchar2(30)      ,/* 自由核算項(八) */
nmbv037       varchar2(30)      ,/* 自由核算項(九) */
nmbv038       varchar2(30)      ,/* 自由核算項(十) */
nmbv039       varchar2(10)      ,/* 經營方式 */
nmbv040       varchar2(10)      ,/* 通路 */
nmbv041       varchar2(10)      ,/* 品牌 */
nmbv103       number(20,6)      ,/* 原幣金額 */
nmbv113       number(20,6)      ,/* 本幣金額 */
nmbv123       number(20,6)      ,/* 本幣二金額 */
nmbv133       number(20,6)      ,/* 本幣三金額 */
nmbvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbvud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmbv042       varchar2(10)      ,/* 現金變動碼 */
nmbv100       varchar2(10)      /* 幣別 */
);
alter table nmbv_t add constraint nmbv_pk primary key (nmbvent,nmbvld,nmbvdocno,nmbvseq,nmbvseq2) enable validate;

create unique index nmbv_pk on nmbv_t (nmbvent,nmbvld,nmbvdocno,nmbvseq,nmbvseq2);

grant select on nmbv_t to tiptop;
grant update on nmbv_t to tiptop;
grant delete on nmbv_t to tiptop;
grant insert on nmbv_t to tiptop;

exit;
