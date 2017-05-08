/* 
================================================================================
檔案代號:fabo_t
檔案名稱:資產出售單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fabo_t
(
faboent       number(5)      ,/* 企業編碼 */
fabold       varchar2(10)      ,/* 帳套 */
fabodocno       varchar2(20)      ,/* 異動單號 */
faboseq       number(10,0)      ,/* 項次 */
fabo000       number(10)      ,/* 資產類型 */
fabo001       varchar2(20)      ,/* 財產編號 */
fabo002       varchar2(20)      ,/* 附號 */
fabo003       varchar2(10)      ,/* 卡片編號 */
fabo004       number(20,6)      ,/* 未折減額 */
fabo005       varchar2(10)      ,/* 單位 */
fabo006       number(20,6)      ,/* 單價 */
fabo007       number(10,0)      ,/* 調撥/出售數量 */
fabo008       number(20,6)      ,/* 成本 */
fabo009       varchar2(10)      ,/* 稅種 */
fabo010       varchar2(10)      ,/* 交易幣種 */
fabo011       number(20,10)      ,/* 原幣匯率 */
fabo012       number(20,6)      ,/* 原幣稅前金額 */
fabo013       number(20,6)      ,/* 原幣稅額 */
fabo014       number(20,6)      ,/* 原幣應收金額 */
fabo015       number(20,6)      ,/* 本幣稅前金額 */
fabo016       number(20,6)      ,/* 本幣稅額 */
fabo017       number(20,6)      ,/* 本幣應收金額 */
fabo018       number(20,6)      ,/* 處置成本 */
fabo019       number(20,6)      ,/* 處置累折 */
fabo020       number(20,6)      ,/* 處置減值準備 */
fabo021       number(20,6)      ,/* 處置本期折舊 */
fabo022       number(20,6)      ,/* 處置未折減額 */
fabo023       varchar2(10)      ,/* 異動原因 */
fabo024       varchar2(24)      ,/* 異動科目 */
fabo025       number(20,6)      ,/* 處置預留殘值 */
fabo026       varchar2(24)      ,/* 累折科目 */
fabo027       varchar2(24)      ,/* 減值準備科目 */
fabo028       varchar2(24)      ,/* 資產科目 */
fabo029       varchar2(24)      ,/* 應收帳款科目 */
fabo030       varchar2(24)      ,/* 稅額科目 */
fabo031       varchar2(10)      ,/* 營運據點 */
fabo032       varchar2(10)      ,/* 部門 */
fabo033       varchar2(10)      ,/* 利潤/成本中心 */
fabo034       varchar2(10)      ,/* 區域 */
fabo035       varchar2(10)      ,/* 交易客商 */
fabo036       varchar2(10)      ,/* 帳款客商 */
fabo037       varchar2(10)      ,/* 客群 */
fabo038       varchar2(20)      ,/* 人員 */
fabo039       varchar2(20)      ,/* 專案編號 */
fabo040       varchar2(30)      ,/* WBS */
fabo041       varchar2(20)      ,/* 帳款編號 */
fabo042       varchar2(40)      ,/* 摘要 */
fabo043       varchar2(10)      ,/* 調出管理組織 */
fabo044       varchar2(10)      ,/* 調出所有組織 */
fabo045       varchar2(10)      ,/* 調出核算組織 */
fabo046       varchar2(10)      ,/* 調入管理組織 */
fabo047       varchar2(10)      ,/* 調入所有組織 */
fabo048       varchar2(10)      ,/* 調入核算組織 */
fabo049       number(20,6)      ,/* 處分損益 */
fabo050       varchar2(20)      ,/* 應收帳款單號 */
fabo051       number(20,6)      ,/* 交易價格差異 */
fabo052       varchar2(20)      ,/* 應付帳款單號 */
fabo053       number(20,6)      ,/* 已計提減值準備 */
fabo054       varchar2(40)      ,/* 經營方式 */
fabo055       varchar2(40)      ,/* 渠道 */
fabo056       varchar2(40)      ,/* 品牌 */
fabo060       varchar2(10)      ,/* 自由核算項一 */
fabo061       varchar2(10)      ,/* 自由核算項二 */
fabo062       varchar2(10)      ,/* 自由核算項三 */
fabo063       varchar2(10)      ,/* 自由核算項四 */
fabo064       varchar2(10)      ,/* 自由核算項五 */
fabo065       varchar2(10)      ,/* 自由核算項六 */
fabo066       varchar2(10)      ,/* 自由核算項七 */
fabo067       varchar2(10)      ,/* 自由核算項八 */
fabo068       varchar2(10)      ,/* 自由核算項九 */
fabo069       varchar2(10)      ,/* 自由核算項十 */
fabo101       varchar2(10)      ,/* 本位幣二幣別 */
fabo102       number(20,10)      ,/* 本位幣二匯率 */
fabo103       number(20,6)      ,/* 本位幣二稅前金額 */
fabo104       number(20,6)      ,/* 本位幣二稅額 */
fabo105       number(20,6)      ,/* 本位幣二應收金額 */
fabo106       number(20,6)      ,/* 本位幣二處份損益 */
fabo107       number(20,6)      ,/* 本位幣二處置成本 */
fabo108       number(20,6)      ,/* 本位幣二處置累折 */
fabo109       number(20,6)      ,/* 本位幣二處置減值準備 */
fabo110       number(20,6)      ,/* 本位幣二本期處置折舊 */
fabo111       number(20,6)      ,/* 本位幣二處置後未折減額 */
fabo150       varchar2(10)      ,/* 本位幣三幣別 */
fabo151       number(20,10)      ,/* 本位幣三匯率 */
fabo152       number(20,6)      ,/* 本位幣三稅前金額 */
fabo153       number(20,6)      ,/* 本位幣三稅額 */
fabo154       number(20,6)      ,/* 本位幣三應收金額 */
fabo155       number(20,6)      ,/* 本位幣三處份損益 */
fabo156       number(20,6)      ,/* 本位幣三處置成本 */
fabo157       number(20,6)      ,/* 本位幣三處置累折 */
fabo158       number(20,6)      ,/* 本位幣三處置減值準備 */
fabo159       number(20,6)      ,/* 本位幣三本期處置折舊 */
fabo160       number(20,6)      ,/* 本位幣三處置後未折減額 */
faboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faboud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabo_t add constraint fabo_pk primary key (faboent,fabold,fabodocno,faboseq) enable validate;

create unique index fabo_pk on fabo_t (faboent,fabold,fabodocno,faboseq);

grant select on fabo_t to tiptop;
grant update on fabo_t to tiptop;
grant delete on fabo_t to tiptop;
grant insert on fabo_t to tiptop;

exit;
