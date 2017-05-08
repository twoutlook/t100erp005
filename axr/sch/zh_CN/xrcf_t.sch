/* 
================================================================================
檔案代號:xrcf_t
檔案名稱:應收沖暫估明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrcf_t
(
xrcfent       number(5)      ,/* 企業代碼 */
xrcfld       varchar2(5)      ,/* 帳別 */
xrcfdocno       varchar2(20)      ,/* 帳款單號 */
xrcfseq       number(10,0)      ,/* 帳款單身項次 */
xrcfseq2       number(10,0)      ,/* 沖銷項次 */
xrcf001       varchar2(10)      ,/* 作業別 */
xrcf002       varchar2(10)      ,/* 沖銷類型 */
xrcf007       number(20,6)      ,/* 沖銷數量 */
xrcf008       varchar2(20)      ,/* 暫估單號碼 */
xrcf009       varchar2(10)      ,/* 暫估單號項次 */
xrcf010       varchar2(10)      ,/* 期別 */
xrcf020       varchar2(10)      ,/* 稅別 */
xrcf021       varchar2(24)      ,/* 應收暫估會科 */
xrcf022       varchar2(24)      ,/* 暫估未稅（收入）會科 */
xrcf023       varchar2(24)      ,/* 暫估稅額會科 */
xrcf024       varchar2(24)      ,/* 沖銷差異科目 */
xrcf025       varchar2(24)      ,/* 沖銷匯率差異科目 */
xrcforga       varchar2(10)      ,/* 來源組織 */
xrcf026       varchar2(10)      ,/* 業務部門 */
xrcf027       varchar2(10)      ,/* 責任中心 */
xrcf028       varchar2(10)      ,/* 區域 */
xrcf029       varchar2(10)      ,/* 交易客商 */
xrcf030       varchar2(10)      ,/* 帳款客商 */
xrcf031       varchar2(10)      ,/* 客群 */
xrcf032       varchar2(10)      ,/* 產品類別 */
xrcf033       varchar2(20)      ,/* 業務人員 */
xrcf034       varchar2(10)      ,/* 專案編號 */
xrcf035       varchar2(10)      ,/* WBS */
xrcf036       varchar2(10)      ,/* 經營方式 */
xrcf037       varchar2(10)      ,/* 渠道 */
xrcf038       varchar2(10)      ,/* 品牌 */
xrcf039       varchar2(30)      ,/* 自由核算項一 */
xrcf040       varchar2(30)      ,/* 自由核算項二 */
xrcf041       varchar2(30)      ,/* 自由核算項三 */
xrcf042       varchar2(30)      ,/* 自由核算項四 */
xrcf043       varchar2(30)      ,/* 自由核算項五 */
xrcf044       varchar2(30)      ,/* 自由核算項六 */
xrcf045       varchar2(30)      ,/* 自由核算項七 */
xrcf046       varchar2(30)      ,/* 自由核算項八 */
xrcf047       varchar2(30)      ,/* 自由核算項九 */
xrcf048       varchar2(30)      ,/* 自由核算項十 */
xrcf049       varchar2(255)      ,/* 摘要 */
xrcf101       number(20,6)      ,/* 原幣單價 */
xrcf102       number(20,10)      ,/* 暫估原幣匯率 */
xrcf103       number(20,6)      ,/* 原幣未稅金額 */
xrcf104       number(20,6)      ,/* 原幣稅額 */
xrcf105       number(20,6)      ,/* 原幣含稅金額 */
xrcf106       number(20,6)      ,/* 原幣沖銷價格差異金額 */
xrcf111       number(20,6)      ,/* 本幣單價 */
xrcf113       number(20,6)      ,/* 本幣未稅金額 */
xrcf114       number(20,6)      ,/* 本幣稅額 */
xrcf115       number(20,6)      ,/* 本幣含稅金額 */
xrcf116       number(20,6)      ,/* 本幣價格差異金額 */
xrcf117       number(20,6)      ,/* 本幣匯差金額 */
xrcf122       number(20,10)      ,/* 暫估本位幣二匯率 */
xrcf123       number(20,6)      ,/* 本位幣二未稅金額 */
xrcf124       number(20,6)      ,/* 本位幣二稅額 */
xrcf125       number(20,6)      ,/* 本位幣二含稅金額 */
xrcf126       number(20,6)      ,/* 本位幣二價格差異金額 */
xrcf127       number(20,6)      ,/* 本位幣二匯差金額 */
xrcf132       number(20,10)      ,/* 暫估本位幣三匯率 */
xrcf133       number(20,6)      ,/* 本位幣三未稅金額 */
xrcf134       number(20,6)      ,/* 本位幣三稅額 */
xrcf135       number(20,6)      ,/* 本位幣三含稅金額 */
xrcf136       number(20,6)      ,/* 本位幣三價格差異金額 */
xrcf137       number(20,6)      ,/* 本位幣三匯差金額 */
xrcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrcf_t add constraint xrcf_pk primary key (xrcfent,xrcfld,xrcfdocno,xrcfseq,xrcfseq2) enable validate;

create  index xrcf_01 on xrcf_t (xrcf008,xrcf009,xrcf010);
create unique index xrcf_pk on xrcf_t (xrcfent,xrcfld,xrcfdocno,xrcfseq,xrcfseq2);

grant select on xrcf_t to tiptop;
grant update on xrcf_t to tiptop;
grant delete on xrcf_t to tiptop;
grant insert on xrcf_t to tiptop;

exit;
