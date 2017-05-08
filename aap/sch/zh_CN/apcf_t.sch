/* 
================================================================================
檔案代號:apcf_t
檔案名稱:應付沖暫估明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apcf_t
(
apcfent       number(5)      ,/* 企業代碼 */
apcfld       varchar2(5)      ,/* 帳別 */
apcforga       varchar2(10)      ,/* 來源組織 */
apcfdocno       varchar2(20)      ,/* 單號 */
apcfseq       number(10,0)      ,/* 項次 */
apcfseq2       number(10,0)      ,/* 項次2 */
apcf001       varchar2(10)      ,/* 作業別 */
apcf002       varchar2(10)      ,/* 沖銷類型 */
apcf007       number(20,6)      ,/* 沖銷數量 */
apcf008       varchar2(20)      ,/* 暫估單號碼 */
apcf009       number(10,0)      ,/* 暫估單號項次 */
apcf010       number(10,0)      ,/* 期別 */
apcf020       varchar2(10)      ,/* 稅別 */
apcf021       varchar2(24)      ,/* 待沖銷應付會科 */
apcf022       varchar2(24)      ,/* 待沖銷未稅會科 */
apcf023       varchar2(24)      ,/* 待沖銷稅額會科 */
apcf024       varchar2(24)      ,/* 沖銷價差科目 */
apcf025       varchar2(24)      ,/* 沖銷會差科目 */
apcf026       varchar2(10)      ,/* 業務部門 */
apcf027       varchar2(10)      ,/* 責任中心 */
apcf028       varchar2(10)      ,/* 區域 */
apcf029       varchar2(10)      ,/* 交易客商 */
apcf030       varchar2(10)      ,/* 帳款客商 */
apcf031       varchar2(10)      ,/* 客群 */
apcf032       varchar2(10)      ,/* 產品類別 */
apcf033       varchar2(20)      ,/* 業務人員 */
apcf034       varchar2(10)      ,/* 專案編號 */
apcf035       varchar2(10)      ,/* WBS */
apcf036       varchar2(10)      ,/* 經營方式 */
apcf037       varchar2(10)      ,/* 渠道 */
apcf038       varchar2(10)      ,/* 品牌 */
apcf039       varchar2(30)      ,/* 自由核算項一 */
apcf040       varchar2(30)      ,/* 自由核算項二 */
apcf041       varchar2(30)      ,/* 自由核算項三 */
apcf042       varchar2(30)      ,/* 自由核算項四 */
apcf043       varchar2(30)      ,/* 自由核算項五 */
apcf044       varchar2(30)      ,/* 自由核算項六 */
apcf045       varchar2(30)      ,/* 自由核算項七 */
apcf046       varchar2(30)      ,/* 自由核算項八 */
apcf047       varchar2(30)      ,/* 自由核算項九 */
apcf048       varchar2(30)      ,/* 自由核算項十 */
apcf049       varchar2(255)      ,/* 摘要 */
apcf101       number(20,6)      ,/* 原幣單價 */
apcf102       number(20,10)      ,/* 原幣匯率 */
apcf103       number(20,6)      ,/* 原幣未稅金額 */
apcf104       number(20,6)      ,/* 原幣稅額 */
apcf105       number(20,6)      ,/* 原幣含稅金額 */
apcf106       number(20,6)      ,/* 原幣沖銷差異金額 */
apcf111       number(20,6)      ,/* 本幣單價 */
apcf113       number(20,6)      ,/* 本幣未稅金額 */
apcf114       number(20,6)      ,/* 本幣稅額 */
apcf115       number(20,6)      ,/* 本幣含稅金額 */
apcf116       number(20,6)      ,/* 本幣價差金額 */
apcf117       number(20,6)      ,/* 本幣匯差金額 */
apcf122       number(20,10)      ,/* 暫估本未幣二匯率 */
apcf123       number(20,6)      ,/* 本位幣二未稅金額 */
apcf124       number(20,6)      ,/* 本位幣二稅額 */
apcf125       number(20,6)      ,/* 本位幣二含稅金額 */
apcf126       number(20,6)      ,/* 本位幣二價格差異金額 */
apcf127       number(20,6)      ,/* 本位幣二匯差 */
apcf132       number(20,10)      ,/* 暫估本位幣三匯率 */
apcf133       number(20,6)      ,/* 本位幣三未稅金額 */
apcf134       number(20,6)      ,/* 本位幣三稅額 */
apcf135       number(20,6)      ,/* 本位幣三含稅金額 */
apcf136       number(20,6)      ,/* 本位幣三價格差異金額 */
apcf137       number(20,6)      ,/* 本位幣三匯差 */
apcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apcf_t add constraint apcf_pk primary key (apcfent,apcfld,apcfdocno,apcfseq,apcfseq2) enable validate;

create  index apcf_n01 on apcf_t (apcfent,apcfld,apcf008,apcf009,apcf010);
create unique index apcf_pk on apcf_t (apcfent,apcfld,apcfdocno,apcfseq,apcfseq2);

grant select on apcf_t to tiptop;
grant update on apcf_t to tiptop;
grant delete on apcf_t to tiptop;
grant insert on apcf_t to tiptop;

exit;
